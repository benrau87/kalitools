#!/bin/bash
#####The following are just available tools that *should* be installed with Kali###
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | tee -a /etc/apt/sources.list

echo "Updating Kali"
apt-get update && apt-get dist-upgrade -y -qq

mkdir ~/git

cd ~/git

echo "Downloading Discovery"
git clone --quiet https://github.com/leebaird/discover.git
cd discover
./update.sh

cd ~/git

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
