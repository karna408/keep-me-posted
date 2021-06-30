#!/bin/sh

. /var/t-app/venv/bin/activate
cd /var/t-app/
python manage.py deploy

exec gunicorn -b :5000 --access-logfile - --error-logfile - manage:app
