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
root_password_sha2 = echo -n rootpassword | shasum -a 256
sudo nano /etc/graylog/server/server.conf
...
password_secret = f7sGd9CqK2IM89LQbv4f4mKDFTuSeY73RcydnAyjvUOj8D4bHJhqUDtTLhkUymQT02GN3vach80IwuArIySo5HsS92bHmwHW
root_password_sha2 = ceba1e03b853ea7dc969a8b1e382f050eab486cca3e3fb0289013d90602538bc
...

## ENABLE GRAYLOG SERVICE
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service

# ###########################################################################
# INSTALLS AND CONFIGURES A GRAYLOG INSTANCE FOR UBUNTU 16.04
# http://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-graylog-on-ubuntu-16-04.html
# ###########################################################################

## TODO :: SETUP NGINX PROXY PASS FOR IP:9000

## INSTALL ORACLE JDK
sudo apt-get remove --purge openjdk*
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
java -version

## INSTALL ELASTICSEARCH
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch.list
sudo apt-get update && sudo apt-get install -y elasticsearch
sudo service elasticsearch restart
sudo systemctl enable elasticsearch
## TODO :: ELASTICSEARCH CONFIGURATION

## TEST YOUR SETUP FOR ELASTICSEARCH
sudo service elasticsearch restart
curl -X GET http://45.55.219.217:9200
curl -X GET 'http://45.55.219.217:9200/_cluster/health?pretty=true'


## INSTALL MONGODB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org.list
sudo apt-get update && sudo apt-get install -y mongodb-org

## INSTALL GRAYLOG
cd && wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb
sudo dpkg -i graylog-2.0-repository_latest.deb
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y graylog-server
sudo apt-get install pwgen
## TODO :: PASSWORD_SECRET CONFIGURATION TO SERVER.CONF
## TODO :: SETUP SERVER.CONF OPTIONS AND CONFIG WEB INTERFACE

## CONFIGURE GRAYLOG ( BUILDER CONFIG )
## GENERATE PASSWORD SECRET: pwgen -N 1 -s 96
## GENERATE "${PASSWORD}" SHA256 HASH: echo -n yourpassword | shasum -a 256
## ENSURE PORTS AVAILABLE FOR NODE AND GRAYLOG COMMUNICATION
## SEE BELOW FOR A GUIDE ON SETTING CONFIGS

## START SERVICES AND DAEMONS
sudo systemctl daemon-reload

sudo systemctl enable elasticsearch

sudo systemctl start mongod
sudo systemctl enable mongod

sudo systemctl restart graylog-server
sudo systemctl enable graylog-server

