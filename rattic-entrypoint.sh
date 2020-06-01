#!/usr/bin/env bash

# immediate exit on failure
set -e

# make conf from environ
python <<-END
import os
from jinja2 import Template
with open('conf/local.cfg', 'w') as f:
    tpl = Template(open('rattic-local.cfg').read())
    f.write(tpl.render(**os.environ))
END

if [ "$1" = init ]
then
    # import gpg key
    gpg --import /opt/rattic_public.key
    # sync db
    ./manage.py syncdb --noinput
    ./manage.py migrate --all --noinput
    # collect static
    ./manage.py collectstatic -c --noinput
    # create initial user
    read -p "Password for super-user: " -s rattic_user_pwd && \
    declare -x rattic_user_pwd=$rattic_user_pwd && \
    ./manage.py shell <<-END
import os
from django.contrib.auth.models import User
User.objects.create_superuser(os.environ['rattic_user_username'], os.environ['rattic_user_email'], os.environ['rattic_user_pwd'])
END

elif [ "$1" = manage ]
then
    shift;
    exec ./manage.py $*
else

  # run gunicorn
  exec /usr/local/bin/gunicorn --bind=0.0.0.0:8000 --access-logfile=- ratticweb.wsgi:application

fi
