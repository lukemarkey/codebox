## IF MOVING STAGING TO PRODUCTION, DISABLE SSL INSECURE CONTENT FIXER

## DOWNLOAD WORDPRESS TO SERVER

wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
sudo mv wordpress /usr/share/nginx/${SITE_NAME}
rm ~/latest.tar.gz

cd /usr/share/nginx/${SITE_NAME}
cp wp-config-sample.php wp-config.php
mkdir wp-content/upgrade

sudo touch /usr/share/nginx/logs/${SITE_NAME}.log
sudo chown -R www-data:www-data /usr/share/nginx/logs/${SITE_NAME}.log
sudo chmod 644 /usr/share/nginx/logs/${SITE_NAME}.log

sudo chown -R www-data:www-data /usr/share/nginx/${SITE_NAME}
sudo find /usr/share/nginx/${SITE_NAME} -type d -exec chmod g+s {} \;
sudo chmod g+w /usr/share/nginx/${SITE_NAME}/wp-content
sudo chmod -R g+w /usr/share/nginx/${SITE_NAME}/wp-content/themes
sudo chmod -R g+w /usr/share/nginx/${SITE_NAME}/wp-content/plugins

curl -s https://api.wordpress.org/secret-key/1.1/salt/
sudo nano /usr/share/nginx/${SITE_NAME}/wp-config.php
---
define('DB_NAME', '${DATABASE}');
define('DB_USER', '${USER}');
define('DB_PASSWORD', '${PASSWORD}');

define('FS_METHOD', 'direct');

define('AUTH_KEY',         'UC+g>~_(`ahEM;Hr`<UpYZX2nJd7%|+cmW--1(DB&;~WmmY5|4=JP]%~l+0d8|aI');
define('SECURE_AUTH_KEY',  '@;r4__If+9g]hQh[&&UF&<iErm;$R%TwO3BmHfPBdkKZr]7JR/z^_-F^NfGLu|}1');
define('LOGGED_IN_KEY',    'Is{G9HRN>x3S0p7AGz^J><[vLce;HWDh zEerWc]+-;4OI@g~-IE-wUTc=bzUt+?');
define('NONCE_KEY',        'T,oz:7cacWR(&JPQ%2FS=Dg+QVFI^S(ieJN^XmG``6@6B*nd7.{d$[ uERat[f%[');
define('AUTH_SALT',        'Vw6vuhWbisDa~].WeqEmo:C{m5<[9ACtd5ReYEZqt{Dh|>.;d%#%+@*2`%4+M8jU');
define('SECURE_AUTH_SALT', '.* ft[eR&43fQ 5_?h&<#i>N}@y_%|d#!L+|-87>ub/QS{b6nLUEe7{zj0^+=c7;');
define('LOGGED_IN_SALT',   '$l10jEdq-Tsjw7E~T$_Uk |!S`4F+1X-w,E.@ZV[KUi$~ds14jC1}O]+D; OD {-');
define('NONCE_SALT',       '/|{-4qfska%eA$12SkZ0j$1Xj?.@9d&`8Apc.&D`EvDFc*Rnyh|:FDyERkKivgp^');

$table_prefix = 'wpluke_'

define('WP_DEBUG', false);
# define('WP_DEBUG_DISPLAY', false);

@ini_set('log_errors', 'On');
@ini_set('error_log', '/usr/share/nginx/logs/${SITE_NAME}.log');
@ini_set('display_errors', 'Off');

# define('WP_MEMORY_LIMIT', '256M');
set_time_limit(400);
---

## CREATE DATABASE FOR WORDPRESS SITE

mysql -u ${USER} -p
CREATE DATABASE ${DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## SET UPLOAD FILE SIZE FOR PHP FPM AND NGINX

sudo nano /etc/php/7.0/fpm/php.ini
---
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 900
max_input_time = 900
---

sudo nano /etc/nginx/nginx.conf
---
client_max_body_size 64m;
---

sudo nano /usr/share/nginx/${SITE_NAME}/wp-config.php
---
define('WP_MEMORY_LIMIT', '512M');
---

sudo service nginx restart
sudo service php7.0-fpm restart

###########################################################################
## REMOVE WORDPRESS WEBSITE FROM SERVER
## CHECK ROUTE53 TO REMOVE RECORDS AFTER WEBSITE IS DELETED
###########################################################################

df -h ## CHECK DISK SPACE USAGE
sudo certbot certificates
sudo certbot delete --cert-name ${DOMAIN_ONE}
sudo rm /etc/nginx/sites-enabled/${DOMAIN}
sudo nginx -t
sudo service nginx restart
sudo rm -rf /usr/share/nginx/${DOMAIN}
df -h ## CHECK NEW DISK SPACE AVAIALBLE
