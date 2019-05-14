## SETUP CONFIGURATION
#
# postmaster@rivercanton.com
# markey$24
#
# https://mail.${DOMAIN}.com/mail/
# https://mail.${DOMAIN}.com/sogo/
# https://mail.${DOMAIN}.com/netdata/
# https://mail.${DOMAIN}.com/iredadmin/

## SETUP PTR RECORD
# PTR RECORDS are setup through the ISP (DIGITAL OCEAN IS THEIR OWN ISP)
# MAKE SURE HOSTNAME ON DIGITAL OCEAN SAME FOR DOMAIN (MAIL.RIVERCANTON.COM)

## EDIT DNS SETTINGS

MX 			@ 								1 mail.${DOMAIN}.com
A 			mail 							${IP_ADDRESS}

## EDIT DNS AFTER INSTALLATION

TXT			@								v=spf1 mx ~all
PTR			${REVERSE_IP}.in-addr.arpa 		${IP_ADDRESS}

## IREDMAIL ON FRESH SERVER

sudo apt-get update; sudo apt-get upgrade

sudo hotnamectl set-hostname mail.${DOMAIN}.com
sudo nano /etc/hosts
---
127.0.0.1 mail.rivercanton.com localhost
---

wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.8.tar.bz2
tar xvf iRedMail-0.9.8.tar.bz2
cd iRedMail-0.9.8
chmod +x iRedMail.sh
sudo bash iRedMail.sh

sudo shutdown -r now

sudo apt install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install certbot

sudo certbot certonly --webroot --agree-tos --email luke.h.markey@gmail.com -d mail.${DOMAIN}.com -w /var/www/html/

sudo nano /etc/nginx/templates/ssl.tmpl
---
ssl_certificate /etc/letsencrypt/live/mail.${DOMAIN}.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/mail.${DOMAIN}.com/privkey.pem;
---

sudo nano /etc/postfix/main.cf
---
smtpd_tls_key_file = /etc/letsencrypt/live/mail.${DOMAIN}.com/privkey.pem
smtpd_tls_cert_file = /etc/letsencrypt/live/mail.${DOMAIN}.com/cert.pem
smtpd_tls_CAfile = /etc/letsencrypt/live/mail.${DOMAIN}.com/chain.pem
---

sudo nano /etc/dovecot/dovecot.conf
---
ssl_cert = </etc/letsencrypt/live/mail.${DOMAIN}.com/fullchain.pem
ssl_key = </etc/letsencrypt/live/mail.${DOMAIN}.com/privkey.pem
---

sudo crontab -e
---
@daily letsencrypt renew --quiet && /usr/sbin/postfix reload && /usr/sbin/dovecot reload && systemctl reload apache2
---

sudo nano /var/www/html/index.html
---
<html><head><meta HTTP-EQUIV="REFRESH" content="0; url=/sogo/"></head></html>
---

## CHECK HOSTNAME FOR PTR RECORD

dig -x ${IP_ADDRESS} +short

31.93.142.in-addr.arpa.${DOMAIN}.com 	PTR		${IP_ADDRESS}

## DIGITAL OCEAN ALREADY WRITES THE PTR RECORD
## USE A VALID HOSTNAME FOR NAMING THE DROPLET
## ENSURE SERVER ALSO VALIDATES HOSTNAME 'hostname'
## AS ROOT

## SETUP MAIL FORWARDING

mysql -u root -p
show databases;
use vmail;
show tables;
select * from forwardings;

## ADD FORWARDING

INSERT INTO forwardings (address, forwarding, domain, dest_domain, is_forwarding, active) VALUES ('user@domain.com', 'forward@example.com', 'domain.com', 'example.com', 1, 1);

## DELETE FORAWRDING

DELTE FROM forwardings WHERE id = 1;

