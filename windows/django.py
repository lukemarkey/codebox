## CREATE VIRTUAL ENV IN PROJECT
virtualenv venv

## ACTIVATE VENV
venv/Scripts/activate

## DEACTIVATE VENV
deactivate

## INSTALL REQUIREMENTS IN VENV
py -m pip install Django
py -m pip install -r requirements.txt

## EXPORT REQUIREMENTS
pip freeze > requirements.txt

## PIP
pip list

## DUMP DATABASE TABLE DATA TO FIXTURE
py manage.py dumpdata auth.User --indent 4 > users.json