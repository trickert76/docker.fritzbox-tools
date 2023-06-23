#!/bin/sh

nmap -sn -oX /tmp/nmap-fastscan.trace $LAN_NETWORK
mv /tmp/nmap-fastscan.trace /var/log/nmap-fastscan.xml

#eof 