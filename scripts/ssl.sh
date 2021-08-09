## INSTALL CERBOT FOR NGINX (OLD)

sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx

## INSTALL CERTBOT FOR UBUNTU FOCAL

sudo apt install certbot python3-certbot-nginx

## SETUP LETS ENCRYPT THROUGH CERTBOT (CONFLICTED WITH NGINX)

sudo certbot --nginx -d ${DOMAIN_ONE} -d ${DOMAIN_TWO}

## SETUP CERTBOT CERTONLY (RUNS FINE WITH NGINX)

certbot certonly --standalone -d $DOMAIN_ONE
sudo chmod -R 755 /etc/letsencrypt

## SSL PROPERTIES ON NGINX SERVER BLOCK
listen 443 ssl; # managed by Certbot
ssl_certificate /etc/letsencrypt/live/atlwebsitedesign.com/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/atlwebsitedesign.com/privkey.pem; # managed by Certbot
include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

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

server {
        #listen 80;
        server_name aimresearchnetwork.com aimresearchservices.com aimresearchnetwork.net www.aimrese$
        return 301 https://www.aimresearchnetwork.com$request_uri;
}
