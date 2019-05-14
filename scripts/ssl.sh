## INSTALL CERBOT FOR NGINX

sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx

## SETUP LETS ENCRYPT THROUGH CERTBOT

sudo certbot --nginx -d ${DOMAIN_ONE} -d ${DOMAIN_TWO}

sudo certbot renew --dry-run
sudo certbot renew --cert-name ${DOMAIN_ONE} --dry-run

sudo service nginx restart

## REMOVE CERTIFICATE FROM CERTBOT

sudo certbot certificates
sudo cerbot delete --cert-name ${DOMAIN}
sudo nano /etc/nginx/sites-available/${DOMAIN}
---
${NGINX_CERBOT_SERVER_BLOCK}
---
