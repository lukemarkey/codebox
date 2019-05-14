## AUDIT PORTS ON SYSTEM

netstat

## GET ALL NETWORK TRAFFIC ON ETHERNET

sudo tcptrack -i eno1

## WHOIS

sudo apt-get install whois

## DIG

dig -t any ${DOMAIN}

## REFRESH NAMESERVER UPDATES FOR BROWSERS

sudo apt install nscd
sudo /etc/init.d/networking restart
