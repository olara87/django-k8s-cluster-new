#!/bin/bash
SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL:-"hello@teamcfe.com"}
cd /app/
/opt/venv/bin/python manage.py collectstatic --noinput