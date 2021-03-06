
#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
gitdir=$PWD

##Logging setup
logfile=/var/log/linux_enum.log
mkfifo ${logfile}.pipe
tee < ${logfile}.pipe $logfile &
exec &> ${logfile}.pipe
rm ${logfile}.pipe

##Functions
function print_status ()
{
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}

function print_good ()
{
    echo -e "\x1B[01;32m[*]\x1B[0m $1"
}

function print_error ()
{
    echo -e "\x1B[01;31m[*]\x1B[0m $1"
}

function print_notification ()
{
	echo -e "\x1B[01;33m[*]\x1B[0m $1"
}

function error_check
{

if [ $? -eq 0 ]; then
	print_good "$1 successfully."
else
	print_error "$1 failed. Please check $logfile for more details."
exit 1
fi

}

function install_packages()
{

apt-get update &>> $logfile && apt-get install -y --allow-unauthenticated ${@} &>> $logfile
error_check 'Package installation completed'

}

function dir_check()
{

if [ ! -d $1 ]; then
	print_notification "$1 does not exist. Creating.."

	mkdir -p $1
else
	print_notification "$1 already exists. (No problem, We'll use it anyhow)"
fi

}
########################################
##BEGIN MAIN SCRIPT##

export DEBIAN_FRONTEND=noninteractive

echo "What is the IP address of the host?"
read IP

echo "What is the port you would like to check?"
read port

today=`date '+%Y_%m_%d'`

dir_check /root/Desktop/Engagements
dir_check /root/Desktop/Engagements/Session_$today

casefolder=/root/Desktop/Engagements/Session_$today

print_notification "Running enumeration"
enum4linux -a $IP > $casefolder/enum4linux.$IP.log 

print_notification "Running directory checker"
dirb http://$IP:$port -Sw > $casefolder/full_dirb.$IP.$port.log
cat $casefolder/full_dirb.$IP.log | grep 'DIRECTORY' | cut -c15-99 > $casefolder/open_dirb.$IP.$port.log

print_notification "Running Vuln Scan"
nikto -h $IP -p $port > $casefolder/nikto80.$IP.$port.log
nikto -h -ssl $IP -p $port > $casefolder/nikto443.$IP.$port.log
print_notification "Complete"
echo "Results are in $casefolder"
