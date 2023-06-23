#!/bin/sh

fb_tools ${FRITZ_BOX_URL} mode:GetIp > /var/log/fritzbox-getip.log
fb_tools ${FRITZ_BOX_URL} mode:Traffic > /var/log/fritzbox-traffic.log
fb_tools ${FRITZ_BOX_URL} mode:SmartHome json /var/log/fritzbox-smarthome.json
fb_tools ${FRITZ_BOX_URL} mode:Anrufliste /var/log/fritzbox-anrufliste.csv -cs:";"
