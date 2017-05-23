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
logfile=/var/log/kali_install.log
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

echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | tee -a /etc/apt/sources.list

echo "Adding some things that are nice to have"
apt-get -qq update && apt-get -y upgrade && apt-get -y install -f && apt-get autoremove
install_packages aptitude pluma gedit gcc-multilib python-m2crypto -y 

service postgresql start  &>> $logfile
update-rc.d postgresql enable  &>> $logfile
systemctl enable postgresql.service  &>> $logfile


mkdir $HOME/Desktop/Tools &>> $logfile
cp -r kalitools $HOME/Desktop/Tools/  &>> $logfile
cd $HOME/Desktop/Tools  &>> $logfile

echo "Downloading Discovery"
git clone --quiet https://github.com/leebaird/discover.git &>> $logfile
cd discover/ &>> $logfile
./update.sh

cd $HOME/Desktop/Tools

echo "Downloading Wordhound"
git clone --quiet https://github.com/kurobeats/wordhound.git &>> $logfile
cd wordhound/ &>> $logfile
python setup.py install && ./setup.sh 

cd $HOME/Desktop/Tools

print_status "Downloading Seclists"
git clone --quiet https://github.com/benrau87/SecLists.git &>> $logfile

print_status "Downloading EmPyre"
git clone --quiet https://github.com/adaptivethreat/EmPyre.git &>> $logfile

print_status  "Downloading MailSniper"
git clone --quiet https://github.com/dafthack/MailSniper.git &>> $logfile

print_status  "Downloading DomainPassSpray"
git clone --quiet https://github.com/dafthack/DomainPasswordSpray.git &>> $logfile

print_status  "Downloading Bloodhound"
git clone --quiet https://github.com/adaptivethreat/BloodHound.git &>> $logfile

print_status  "Downloading KeeThief"
git clone --quiet https://github.com/adaptivethreat/KeeThief.git &>> $logfile

print_status  "Downloading and making MimiKatz"
git clone --quiet https://github.com/gentilkiwi/mimikatz.git &>> $logfile
wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip &>> $logfile
unzip -d /mimikatz_trunk.zip &>> $logfile

print_status  "Downloading WIFIPhisher"
git clone --quiet https://github.com/sophron/wifiphisher.git &>> $logfile

print_status  "Downloading Easy-P"
git clone --quiet https://github.com/cheetz/Easy-P.git &>> $logfile

print_status  "Downloading Powershell-Suite"
git clone --quiet https://github.com/FuzzySecurity/PowerShell-Suite.git &>> $logfile

print_status  "Net-cred Sniffer"
git clone --quiet https://github.com/DanMcInerney/net-creds.git &>> $logfile

print_status  "Downloading Spiderfoot"
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
pip install -r requirements.txt &>> $logfile
pip install --upgrade beautifulsoup4 &>> $logfile
pip install --upgrade html5lib &>> $logfile



