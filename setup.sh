#!/bin/bash
#####The following are just available tools that *should* be installed with Kali###
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

mkdir ~/git

cd ~/git

echo "Downloading Discovery"
git clone --quiet https://github.com/leebaird/discover.git
cd discover
./update.sh

cd ~/git

echo "Downloading Seclists"
git clone --quiet https://github.com/benrau87/SecLists.git

echo "Downloading PowerSploit"
git clone --quiet https://github.com/PowerShellMafia/PowerSploit.git

echo "Downloading EmPyre"
git clone --quiet https://github.com/adaptivethreat/EmPyre.git

echo "Downloading MailSniper"
git clone --quiet https://github.com/dafthack/MailSniper.git

echo "Downloading DomainPassSpray"
git clone --quiet https://github.com/dafthack/DomainPasswordSpray.git

echo "Downloading DomainPassSpray"
git clone --quiet https://github.com/adaptivethreat/BloodHound.git

