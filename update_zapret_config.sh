#!/bin/sh

##
# Script for OpenWRT & zapret 
# - Fix problem with time 
# - Update zapret config file 
#
# NOTE:
#
# Add perm for run chmod +x ./update_zapret_config.sh
#
# --== exmpl cron tab ==-- 
# 17 3 * * * ./update_zapret_config.sh
#
# --== autostart ==--
# add '/root/update_zapret_config.sh' to /etc/rc.local
##

## CONSTANTS 
# link to files: config and hosts

CNF_URL='https://raw.githubusercontent.com/seraved/yt_config/refs/heads/main/rpi_config'
HST_URL='https://raw.githubusercontent.com/seraved/yt_config/refs/heads/main/youtube.txt'

# path to file config and hosts

CNF_PATH='/opt/zapret/config'
HST_PATH='/opt/zapret/ipset/zapret-hosts-google.txt'

SLEEP_TIME=10

## MAIN 
main(){
  sleep $((SLEEP_TIME))

  if ping -c 1 google.com &> /dev/null
  then
    echo "internet is OK"
    update_time
    update_zapret_cnf
  else 
    echo "No internet connection" 
  fi
}

# func for update time 
update_time(){
  ntpd -q -p ptbtime1.ptb.de
  
  echo "system time has been updated"
}

# func for download and update zapret config file 
update_zapret_cnf() {
  
  # download files and update
  wget -O $CNF_PATH $CNF_URL
  wget -O $HST_PATH $HST_URL
  
  # restart zapret
  /etc/init.d/zapret restart
  
  echo "zapret cnf has been updated"
}

# RUN 
main
