#!/bin/bash
#User working on the system
USERNAME=$(whoami)
#Current Date an d Time of the system
DATE=$(date)

#System Info
HOSTNAME=$(hostname)
#Name and version of the Operating System
OS=$(source /etc/os-release && echo "$NAME $VERSION")
#Total working time on the system
UPTIME=$(uptime -p)

#Hardware Info
CPU=$(sudo lshw -class processor | grep 'product' | awk -F: '{print $2}' | xargs)
SPEED=$(sudo lscpu | grep 'MHz' | awk -F: '{print $2}' | xargs)
RAM=$(sudo free -h | grep 'Mem' | awk '{print $2}')
DISKS=$(sudo lsblk -d -o model,size | tail -n +2)

#Network Info
#Fully Qualified Domain Name
FQDN=$(hostname -f)
Host_IP=$(hostname -I | awk '{print $1}')
GATEWAY_IP=$(ip r | grep default | awk '{print $3}')

#System Status
USERS_LOGGED_IN=$(who | awk '{print $1}' | sort | uniq | paste -sd,)
PROCESS_COUNT=$(ps aux --no-heading | wc -l)
MEMORY_ALLOCATION=$(free -h)

cat << EOF

System Report generated by  $USERNAME, $DATE

System Information
------------------ 
Hostname: $HOSTNAME
OS: $OS
Uptime: $UPTIME

Hardware Information
--------------------
CPU: $CPU
Speed: $SPEED
RAM: $RAM
Disks: $DISKS
Video: $VIDEO

Network Information 
-------------------
FQDN: $FQDN
Host Adress: $Host_IP
Gateway IP: $GATEWAY_IP

System Status
-------------
Users Logged In: $USERS_LOGGED_IN
Process count: $PROCESS_COUNT
Memory Allocation: $MEMORY_ALLOCTION

EOF
