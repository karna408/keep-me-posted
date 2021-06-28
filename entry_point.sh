#!/bin/sh

. /var/t-app/venv/bin/activate
cd /var/t-app/
python manage.py deploy
python manage.py runserver
