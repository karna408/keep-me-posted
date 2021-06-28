#!/bin/sh

. /var/t-app/venv/bin/activate

python /var/t-app/manage.py deploy
python /var/t-app/manage.py runserver
