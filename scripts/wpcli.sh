## SETUP WORDPRESS CLI

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

## WP SEARCH REPLACE

wp search-replace 'http://lsi.markey.agency' 'https://all-synced.com'
wp search-replace 'https://lsi.markey.agency' 'https://all-synced.com'
