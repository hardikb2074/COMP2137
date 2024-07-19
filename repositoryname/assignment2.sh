#!/bin/bash

#Exit immediately if a command exits with a non-zero status
set -e

# Function to update netplan configuration
update_netplan() {

#Write the netplan configuration to /etc/netplan/01-netcfg.yaml
    cat <<EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    ens3:
      dhcp4: no
      addresses:
        - 192.168.16.21/24
EOF

#Apply the new netplan configuration
    netplan apply
    echo "Netplan configuration updated."
}

# Function to install required software
install_software() {
#Update the package list
    apt-get update
#Install Apache2 and Squid 
    apt-get install -y apache2 squid
#Enable Apache2 to start on boot
    systemctl enable apache2
#Enable Squid to start on boot
    systemctl enable squid
    echo "Software installed and enabled."
}

# Function to configure firewall
configure_firewall() {
#Allow SSH, HTTP, and Squid ports on the ens3 interface
    ufw allow in on ens3 to any port 22
    ufw allow in on ens3 to any port 80
    ufw allow in on ens3 to any port 3128
#ALlow SSH, HTTP, and Squid ports on the mgmt interface 
    ufw allow in on mgmt to any port 22
    ufw allow in on mgmt to any port 80
    ufw allow in on mgmt to any port 3128
#Enable the firewall
    ufw enable
    echo "Firewall configured and enabled."

}

# Main script execution starts here

# Update netplan configuration
update_netplan

# Install required software
install_software

# Configure firewall
configure_firewall

#Print a success message
echo "Setup completed successfully."
