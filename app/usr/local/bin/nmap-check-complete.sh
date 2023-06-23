#!/bin/sh

nmap -oX /tmp/nmap-fullscan.trace $LAN_NETWORK
mv /tmp/nmap-fullscan.trace /var/log/nmap-fullscan.xml

#eof 