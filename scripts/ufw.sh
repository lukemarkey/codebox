# INSTALL UFW

sudo apt-get install ufw
sudo ufw disable

## NO ONE ALLOWED IN / ALL OUTGOING OKAY BY DEFAULT

sudo ufw default deny incoming
sudo ufw default allow outgoing

## WEBSERVER PORTS

sudo ufw allow https

## SSH CONFIG
## HOME IP 73.82.241.34

sudo ufw allow from ${SERVER_IP} to any port 22 ## SPECIFIC TO STATIC IP
sudo ufw allow ssh ## ALTERNATIVE GENERIC

## MAIL SERVER PORTS

sudo ufw allow 25
sudo ufw allow 587
sudo ufw allow 2525

## LOGGING

sudo ufw logging on

## GRAYLOG PORTS

sudo ufw allow 9000 ## GRAYLOG INTERFACE
sudo ufw allow 9200:9300/tcp ## ELASTICSEARCH HTTP API - NODE DISCOVERY
sudo ufw allow 12900 ## GRAYLOG WEB INTERFACE
sudo ufw allow from 127.0.0.1 to 127.0.0.1 port 1514/udp ## GRAYLOG LOCALHOST SYSLOG
