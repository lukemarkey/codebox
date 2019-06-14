## DJANGO COMMANDS

django-admin startproject ${PROJECT_NAME}
django-admin startapp ${APP_NAME}

virtualenv -p python3 ${ENV_NAME}

python3 manage.py createsuperuser

## TEST MIGRATIONS

p manage.py migrate --fake

## RESET MIGRATION FILES

find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
pip install --upgrade --force-reinstall Django

## SETUP DJANGO ON LOCALHOST

django-admin startproject ${PROJECT_NAME}
django-admin startapp ${APP_NAME}

virtualenv -p python3 ${ENV_NAME}
pip install django gunicorn psycopg2-binary python-decouple ## ESSENTIAL LIBRARIES
pip install django-honeypot ## USEFUL LIBRARIES
pip freeze > requirements.txt

npm init
npm install node-sass concurrently browser-sync --save-dev

touch .env .env.example .gitignore

cd ${APP_NAME}

touch urls.py

mkdir -p static/website/css static/website/js static/website/img static/website/scss static/website/fonts
mkdir -p templates/website/layout templates/website/components

touch templates/website/layout/layout.html templates/website/layout/header.html templates/website/layout/footer.html
touch templates/website/about.html templates/website/home.html

## SETUP SETTINGS
## SETUP URLS
## SETUP VIEW & TEMPLATE
## SETUP THEME
## SETUP DEFAULTS
## SETUP MAIL
## SETUP HONEYPOT ('honeypot.middleware.HoneypotMiddleware')

git init

## SETUP DJANGO SITE ON SERVER

sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx

cd ${PROJECT_DIRECTORY}
source env/bin/activate
pip install django gunicorn psycopg2-binary
pip install python-decouple
pip install -r requirements.txt

python3 manage.py collectstatic

## CREATE NEW DATABASE AND USER FOR DJANGO SITE

sudo -u postgres psql
CREATE DATABASE ${DJANGO_DB_NAME};
CREATE USER ${DJANGO_DB_USER} WITH PASSWORD '${DJANGO_DB_PASS}' CREATEDB
ALTER USER ${DJANGO_DB_USER} SET client_encoding TO 'utf8';
ALTER USER ${DJANGO_DB_USER} SET default_transaction_isolation TO 'read committed';
ALTER USER ${DJANGO_DB_USER} SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE ${DJANGO_DB_NAME} TO ${DJANGO_DB_USER};

## SETUP GUNICORN SERVICE ON SERVER

sudo nano /etc/systemd/system/${PROJECT_NAME}.service
---
[Unit]
Description=Gunicorn Daemon for Django Project
After=network.target

[Service]
User=luke
Group=www-data
WorkingDirectory=/home/luke/projects/${PROJECT_NAME}
ExecStart=/home/luke/projects/${PROJECT_NAME}/env/bin/gunicorn --workers 3 --bind unix:/home/luke/projects/${PROJECT_NAME}/${PROJECT_NAME}.sock ${PROJECT_NAME}.wsgi:application

[Install]
WantedBy=multi-user.target
---
sudo systemctl start ${PROJECT_NAME}
sudo systemctl status ${PROJECT_NAME}
sudo systemctl enable ${PROJECT_NAME}
