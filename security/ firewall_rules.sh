#!/bin/bash
# Configure secure firewall

ufw default deny incoming
ufw default allow outgoing

# Allow only required ports
ufw allow 8080/tcp  # Management API
ufw allow 443/tcp   # Secure communications
ufw allow 22/tcp    # SSH

# Enable intrusion detection
apt install -y fail2ban
systemctl enable fail2ban

# Set up automatic updates
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades