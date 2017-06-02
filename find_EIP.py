#!/usr/bin/python

import sys, socket
from time import sleep
 
# set arguments
ip = raw_input("Enter the IP address of the target: ")
port = input("Enter port number: ")
buff = raw_input("Enter in your unique buffer: ")

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((ip,port))
s.recv(2048)
print "Sending buffer"
s.send(buff)
s.close()
sleep(1)
sys.exit()
