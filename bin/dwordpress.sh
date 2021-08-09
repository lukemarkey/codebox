#!/bin/bash

SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

read -r -d '' FILE_WPCONFIG <<-'EOF'
test
one
two
EOF

echo "${FILE_WPCONFIG}"

echo -n "What is the name of your wordpress project? (Example: portfolio): "
read SITE_NAME
echo -n "What is the name of your wordpress database? (Example: portfolio): "
read DATABASE
echo -n "What is the name of your database username? (Example: user): "
read USER
echo -n "What is your database password? (Example: admin): "
read PASSWORD

echo "${SITE_NAME}"
echo "${DATABASE}"
echo "${USER}"
echo "${PASSWORD}"




