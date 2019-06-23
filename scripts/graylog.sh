#!/bin/bash

###########################################################################
## GRAYLOG INSTALL PROCEDURE
###########################################################################

sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get install -y apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen

## INSTALL MONGODB 4.0
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get -y update
sudo apt-get install -y mongodb-org
## ENABLE MONGODB SERVICE
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service

## INSTALL GRAYLOG
wget https://packages.graylog2.org/repo/packages/graylog-3.0-repository_latest.deb
sudo dpkg -i graylog-3.0-repository_latest.deb
sudo apt-get update
sudo apt-get install -y graylog-server

## UPDATE GRAYLOG SERVER CONF
password_secret = pwgen -N 1 -s 96
root_password_sha2 = echo -n home8020admin42graylog | shasum -a 256
sudo nano /etc/graylog/server/server.conf
...
password_secret = f7sGd9CqK2IM89LQbv4f4mKDFTuSeY73RcydnAyjvUOj8D4bHJhqUDtTLhkUymQT02GN3vach80IwuArIySo5HsS92bHmwHW
root_password_sha2 = ceba1e03b853ea7dc969a8b1e382f050eab486cca3e3fb0289013d90602538bc
...

## ENABLE GRAYLOG SERVICE
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service

## CONFIGURE NGINX REVERSE PROXY
sudo nano /etc/nginx/sites-available/graylog
...
server {
	server_name graylog.atlwebsitedesign.com;

	location / {
		proxy_set_header Host $http_host;
		proxy_set_header X-Forwarded-Host $host;
		proxy_set_header X-Forwarded-Server $host;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Graylog-Server-URL https://$server_name/;
		proxy_pass http://127.0.0.1:9000;
	}
}
...
sudo ln -s /etc/nginx/sites-enabled/
sudo certbot --nginx -d graylog.atlwebsitedesign.com

## CONFIGURE RSYSLOG FORWARDING TO GRAYLOG FOR REMOTE (REMOTE SYS LOG)
sudo apt install -y rsyslog
sudo nano /etc/rsyslog.d/30-graylog.conf
...
## UDP
*.* @graylog.atlwebsitedesign.com:514;RSYSLOG_SyslogProtocol23Format
## TCP
*.* @@graylog.atlwebsitedesign.com:514;RSYSLOG_SyslogProtocol23Format
...


## UPDATE IPTABLES FOR RSYSLOG PORT
iptables -A INPUT -p tcp --dport 514 -j ACCEPT
iptables -A INPUT -p udp --dport 514 -j ACCEPT

## CHECK PORT 514 CONNECTIONS
ss -tunelp | grep 514
