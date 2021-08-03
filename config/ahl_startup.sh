#!/bin/bash
#cd /root/hlds && /root/hlds/hlds_run -game action -autoupdate -port 27015 +maxplayers 20 +map ahl_bankdoom_lms +mapcyclefile mapcycle.txt +servercfgfile server.cfg
now=`date +"%m_%d_%Y"`
mkdir -p /var/log/hlds/
cd /root/hlds && /bin/bash hlds_run -dev -debug -game action +ip 0.0.0.0 -autoupdate -port 27015 +maxplayers 20 +map ahl_bankdoom +mapcyclefile mapcycle_dallas1.txt +servercfgfile server_dallas1.cfg >> /var/log/hlds/nowhiners_$now.log 2>&1
