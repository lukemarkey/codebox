###########################################################################
## FILE PATHS FOR NETDATA COMPONENTS
###########################################################################

   # - the daemon    at /usr/sbin/netdata
   # - config files  at /etc/netdata
   # - web files     at /usr/share/netdata
   # - plugins       at /usr/libexec/netdata
   # - cache files   at /var/cache/netdata
   # - db files      at /var/lib/netdata
   # - log files     at /var/log/netdata
   # - pid file      at /var/run

###########################################################################
## INITIAL SETUP FOR BLANK SERVER
###########################################################################

sudo apt-get update

## ADD NEW SUDO USER TO SERVER

adduser ${USERNAME}
usermod -aG sudo ${USERNAME}

sudo nano /etc/ssh/sshd_config
---
AllowUsers root ${USERNAME}
ClientAliveInterval 60
ClientAliveCountMax 10000
---
sudo systemctl reload sshd

sudo su ${USERNAME}
mkdir ~/.ssh && touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys

## INSTALL AND SETUP UFW

sudo apt-get install ufw
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow https
sudo ufw allow http
sudo ufw allow ssh
sudo ufw allow 19999/tcp ## NETDATA PORT ON STANDARD INSTALL
sudo ufw enable

## INSTALL NGINX

sudo apt-get install nginx
sudo systemctl status nginx

sudo systemctl restart nginx ## STOPS AND STARTS SERVICE AGAIN
sudo systemctl reload nginx ## RELOADS SERVICE WITHOUT DROPPING CONNECTIONS

sudo systemctl enable nginx

###########################################################################
## INSTALLING NETDATA
###########################################################################

## INSTALL DEPENDENCIES
sudo apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make autoconf autoconf-archive autogen automake pkg-config curl

## INSTALL OPTIONAL BUT RECOMMENDED LIBRARIES
sudo apt-get install python python-yaml python-mysqldb python-psycopg2 nodejs lm-sensors netcat

## INSTALL NETDATA
git clone https://github.com/firehol/netdata.git --depth=1 ~/netdata
cd ~/netdata
sudo ./netdata-installer.sh

## LEFT OFF ON Step 2 — Configuring Netdata's Memory Usage
## https://www.digitalocean.com/community/tutorials/how-to-set-up-real-time-performance-monitoring-with-netdata-on-ubuntu-16-04
