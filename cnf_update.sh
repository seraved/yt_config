#!/bin/sh

#
# Add perm for run chmod +x ./cnf_update.sh
#
# --== exmpl cron tab ==-- 
# 17 3 * * * ./cnf_update.sh 
#
# --== autostart ==--
# add '/root/cnf_update.sh' to /etc/rc.local

# link to files: config and hosts
CNF_URL='https://raw.githubusercontent.com/seraved/yt_config/refs/heads/main/config'
HST_URL='https://raw.githubusercontent.com/seraved/yt_config/refs/heads/main/youtube.txt'

# wait 10s
sleep 10

# path to file config and hosts
CNF_PATH='/opt/zapret/config'
HST_PATH='/opt/zapret/ipset/youtube.txt'

# download files and update
wget -O $CNF_PATH $CNF_URL
wget -O $HST_PATH $HST_URL

# restart zapret
/etc/init.d/zapret restart

