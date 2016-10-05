#Scans network passively and outputs to pwd with scan.txt
#! /bin/bash
today=`date '+%Y_%m_%d__%H_%M_%S'`

ifconfig

echo Please type interface to listen on
read interface
echo Passive ARP discovery is running...Press CTRL+C to stop.

netdiscover -i $interface -p -P > $HOME/Desktop/passivescan.$today.txt
