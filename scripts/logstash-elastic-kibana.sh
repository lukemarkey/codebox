###########################################################################
## VARIABLES
###########################################################################

ELASTICSEARCH_YML=/etc/elasticsearch/elasticsearch.yml
KIBANA_YML=/opt/kibana/config/kibana.yml
FILEBEAT_YML=/etc/filebeat/filebeat.yml

###########################################################################
## INSTALL LOGSTASH ELASTICSEARCH AND KIBANA ON A CENTRAL SERVER
###########################################################################

## JAVA JDK 8
sudo apt install openjdk-8-jdk
java -version
javac -version
## SET DEFAULT JAVA INSTALL TO JDK 8 IF NECESSARY
sudo update-alternatives --config java
sudo update-alternatives --config javac

## ELASTICSEARCH
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-7.x.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
## UPDATE ELASTICSEARCH_YML
network.host = localhost
indices.fielddata.cache.size: 20%
## UPDATE JVM_OPTIONS
-Xms1g ## MIN HEAP SPACE 1GIG (HALF OF TOTAL RAM)
-Xmx1g ## MAX HEAP SPACE 1GIG (HALF OF TOTAL RAM)
## CHECK IF ELASTICSEARCH IS RUNNING
curl -X GET "localhost:9200/"

## KIBANA
sudo apt install kibana
sudo systemctl enable kibana
sudo systemctl start kibana

## UPDATE KIBANA_YML
server.host = "localhost"

## CREATE KIBANA ADMIN FOR NGINX
sudo apt-get install apache2-utils
echo "luke:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users

## CREATE KIBANA SERVERBLOCK
sudo nano /etc/nginx/sites-available/kibana
sudo ln -s /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled
sudo nginx -t
sudo service nginx restart

## INSTALL CERBOT FOR NGINX

sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx
sudo certbot --nginx -d ${DOMAIN}

## INSTALL LOGSTASH
sudo apt install logstash

## FILEBEAT INPUT
sudo nano /etc/logstash/conf.d/02-beats-input.conf
## SYSTEM LOGS FILTER
sudo nano /etc/logstash/conf.d/10-syslog-filter.conf
## NGINX LOGS FILTER
sudo nano /etc/logstash/conf.d/11-nginx-filter.conf
## ELASTICSEARCH OUTPUT
sudo nano /etc/logstash/conf.d/30-elasticsearch-output.conf

## TEST LOGSTASH
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
## ENABLE LOGSTASH IF ERROR FREE
sudo systemctl start logstash
sudo systemctl enable logstash

## INSTALL FILEBEAT
sudo apt install filebeat

## UPDATE FILEBEAT_YML
sudo nano /etc/filebeat/filebeat.yml
...
#output.elasticsearch:
  # Array of hosts to connect to.
  #hosts: ["localhost:9200"]
output.logstash:
  # The Logstash hosts
  hosts: ["localhost:5044"]
...

## ENABLE FILEBEAT SYSTEM MODULE
sudo filebeat modules enable system
sudo filebeat modules list

## LOAD ELASTICSEARCH INDEX TEMPLATE
sudo filebeat setup --template -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'
## SWITCH LOGSTASH OUTPUT TO ELASTICSEARCH OUTPUT
sudo filebeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['localhost:9200'] -E setup.kibana.host=localhost:5601
## ENABLE FILEBEAT
sudo systemctl start filebeat
sudo systemctl enable filebeat

## TEST FOR FILEBEAT TO SHIP SYSLOG AND AUTH LOG TO LOGSTASH - THEN LOADS TO ELASTICSEARCH
curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty'

## LIST AVAILABLE MODULES
sudo filebeat modules list

## NGINX MODULE
sudo filebeat modules enable nginx
