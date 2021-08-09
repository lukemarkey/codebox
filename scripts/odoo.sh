## INSTALL ODOO ON NEW UBUNTU SERVER
## NEEDS WKHTMLTOPDF 0.12.1 FOR PDF REPORTS

## INSTALL PYTHON PIP AND DEPENDENCIES

sudo apt-get install python3-pip
pip3 install Babel decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock num2words ofxparse passlib Pillow psutil psycogreen psycopg2 pydot pyparsing PyPDF2 pyserial python-dateutil python-openid pytz pyusb PyYAML qrcode reportlab requests six suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd

sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less less-plugin-clean-css
sudo apt-get install node-less

sudo apt-get install python-software-properties
sudo nano /etc/apt/sources.list.d/pgdg.list
---
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
---
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get install postgresql-9.6

## CREATE DATABASE USER FOR ODOO

sudo su postgres
cd
createruser -s odoo
createuser -s luke
createuser -s root
exit

## CREATE ODOO USER AND GROUP

sudo adduser --system --home=/opt/odoo --group odoo

## INSTALL GDATA

cd /opt/odoo
sudo wget https://pypi.python.org/packages/a8/70/bd554151443fe9e89d9a934a7891aaffc63b9cb5c7d608972919a002c03c/gdata-2.0.18.tar.gz
sudo tar zxvf gdata-2.0.18.tar.gz
sudo chown -R odoo: gdata-2.0.18
sudo -s

# ODOO 11 DOWNLOAD

sudo apt-get install git
sudo su - odoo -s /bin/bash
git clone https://www.github.com/odoo/odoo --depth 1 --branch 11.0 --single-branch
exit

## CREATE ODOO LOG FILE

sudo mkdir /var/log/odoo
sudo chown -R odoo:root /var/log/odoo

## EDIT ODOO CONFIGURATION

sudo nano /etc/odoo.conf
---
[options]

; This is the password that allows database operations:
; admin_passwd = admin
db_host = False
db_port = False
db_user = odoo
db_password = False

logfile = /var/log/odoo/odoo-server.log

addons_path = /opt/odoo/addons,/opt/odoo/odoo/addons
---
sudo chown odoo: /etc/odoo.conf

## INSTALL WKHTMLTOPDF

sudo apt-get -f install
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

## START ODOO SERVER

cd /opt/odoo/odoo
./odoo-bin
http://localhost:8069

## ADD ODOO REPOSITORY

sudo su
wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/11.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
apt-get update && apt-get install odoo
