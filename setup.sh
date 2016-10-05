#!/bin/bash
#####The following are just available tools that *should* be installed with Kali###
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | tee -a /etc/apt/sources.list

echo "Updating Kali"
apt-get update && apt-get dist-upgrade -y -qq

apt-get install aptitude pluma gedit

service postgresql start
update-rc.d postgresql enable
service metasploit start

mkdir $HOME/Desktop/Tools

cd $HOME/Desktop/Tools

echo "Downloading Discovery"
git clone --quiet https://github.com/leebaird/discover.git
cd discover/
./update.sh

cd $HOME/Desktop/Tools

echo "Downloading Wordhound"
git clone --quiet https://github.com/kurobeats/wordhound.git
cd wordhound/
python setup.py install && ./setup.sh

cd $HOME/Desktop/Tools

echo "Downloading Seclists"
git clone --quiet https://github.com/benrau87/SecLists.git

echo "Downloading EmPyre"
git clone --quiet https://github.com/adaptivethreat/EmPyre.git

echo "Downloading MailSniper"
git clone --quiet https://github.com/dafthack/MailSniper.git

echo "Downloading DomainPassSpray"
git clone --quiet https://github.com/dafthack/DomainPasswordSpray.git

echo "Downloading Bloodhound"
git clone --quiet https://github.com/adaptivethreat/BloodHound.git

echo "Downloading KeeThief"
git clone --quiet https://github.com/adaptivethreat/KeeThief.git

echo "Downloading and making MimiKatz"
git clone --quiet https://github.com/gentilkiwi/mimikatz.git
wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
unzip -d /mimikatz_trunk.zip

echo "Downloading WIFIPhisher"
git clone --quiet https://github.com/sophron/wifiphisher.git

echo "Downloading Easy-P"
git clone --quiet https://github.com/cheetz/Easy-P.git
