###########################################################################
## SETUP NEW DJANGO PROJECT ON LOCALHOST
###########################################################################

## CREATE NEW DATABASE AND USER FOR DJANGO SITE

sudo -u postgres psql
CREATE DATABASE ${DJANGO_DB_NAME};
CREATE USER ${DJANGO_DB_USER} WITH PASSWORD '${DJANGO_DB_PASS}' CREATEDB;
ALTER USER ${DJANGO_DB_USER} SET client_encoding TO 'utf8';
ALTER USER ${DJANGO_DB_USER} SET default_transaction_isolation TO 'read committed';
ALTER USER ${DJANGO_DB_USER} SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE ${DJANGO_DB_NAME} TO ${DJANGO_DB_USER};

## CREATE SUPER USER FOR DJANGO PROJECT

py manage.py createsuperuserww

## SETUP DJANGO ON LOCALHOST

django-admin startproject ${PROJECT_NAME}
django-admin startapp ${APP_NAME}

virtualenv -p python3 ${ENV_NAME}
pip install django gunicorn psycopg2-binary python-decouple pillow ## ESSENTIAL LIBRARIES
pip install django-honeypot django-recaptcha ## USEFUL LIBRARIES
pip freeze > requirements.txt

npm init
npm install node-sass concurrently browser-sync --save-dev
npm install gulp gulp-concat gulp-series gulp-util gulp-minify-css gulp-uglify gulp-purifycss --save-dev
npm install store noty sweetalert2 vue --save

mkdir -p media media/content media/default
touch .env .env.example .gitignore gulpfile.js

cd ${APP_NAME}

touch urls.py forms.py

mkdir -p static/website/css static/website/js static/website/img static/website/scss static/website/fonts static/website/purify
mkdir -p templates/website/layout templates/website/components templates/website/email
mkdir -p fixtures management/commands

touch fixtures/auth.json fixtures/page.json fixtures/content.json management/commands/seed.py
touch templates/website/layout/layout.html templates/website/layout/header.html templates/website/layout/footer.html
touch templates/website/home.html
touch static/website/scss/website.scss static/website/scss/mobile.scss static/website/scss/options.scss

###########################################################################
## SETUP DJANGO PROJECT ON SERVER
###########################################################################

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

###########################################################################
## RESET MIGRATION FILES FOR DJANGO PROJECT
###########################################################################

p manage.py showmigrations
p manage.py migrate --fake website zero
p manage.py showmigrations
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
pip install --upgrade --force-reinstall django
p manage.py showmigrations
p manage.py makemigrations
p manage.py migrate --fake-initial

python manage.py flush --no-input # FLUSH DATABASE

###########################################################################
## MIGRATE APPS TO PREVENT ERRORS
###########################################################################

p manage.py migrate admin
p manage.py migrate website
p manage.py migrate contenttypes

###########################################################################
## DJANGO DUMP AND LOAD DATABASE DATA
###########################################################################

./manage.py dumpdata > database.json ## ENTIRE PROJECT
./manage.py dumpdata website > website.json ## SPECIFIC APP
./manage.py dumpdata website.model > website.model.json ## APP MODEL

./manage.py loaddata database.json

# VIEW: SEND MAIL

def form_valid(self, form, **kwargs):

	context = self.get_context_data(**kwargs)

	name = form.cleaned_data.get('name')
	from_email = form.cleaned_data.get('email')
	subject = form.cleaned_data.get('subject')
	phone = form.cleaned_data.get('phone')
	message = form.cleaned_data.get('message')

	text_content = "Name: " + name + " Email: " + from_email + " Subject: " + subject + " Phone: " + phone + " Message: " + message
	html_content = render_to_string('website/email/contact-form.html', {
		'name': name,
		'email': from_email,
		'subject': subject,
		'phone': phone,
		'message': message
	})

	send_mail(
		subject = "New River Church Contact Request",
		message = text_content,
		from_email = 'Messenger <mail@rivercanton.com>',
		recipient_list = ['mitch@rivercanton.com', 'mitchellpinion@gmail.com'],
		fail_silently = False,
		html_message = html_content
	)

# VIEW: QUERY MODEL BY MULTIPLE CATEGORIES
from django.db.models import Q
query = Model.objects.filter(Q(category=category) | Q(category1=category), is_active=True)


# TODO: class based view get_queryset function
