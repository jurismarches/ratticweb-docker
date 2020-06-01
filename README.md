# ratticweb-docker

Docker image and docker-compose for [ratticweb](https://github.com/tildaslash/RatticWeb)
a simple online password manager.

**Warning:** ratticweb is an archived project and does not receives security maintenance.
Most of the software it depends upon is really outdated (Django 1.6 / python2.7.8).
(note that there are some forks available that may be in better shape).
Though it may be better to use it only in a secured environment (intranet), not in the wild.

Also this image is primarily targeted at local usage (for recovery)
it DOES NOT use https, which is very important for rattic,
so DO NOT consider it production ready.

However, you could take inspiration upon this image to setup a fork on a more up to date basis.

## Setup

- copy `env-sample` as `.env` and customize it, this parametrize the docker-compose file
- copy `rattic-env-sample` as `.rattic-env` and customize it,
  this parametrize the rattic configuration
- put the public key for backup as rattic_public.key
- you may also add a docker-compose.override.yml
  if you want to change something like the restart policy, or the ports, or add some service

- then run `docker-compose build` to buil rattic image
- also run `docker-compose run --rm rattic init` to initialize database

## Usage

Run `docker-compose up`
And go to http://localhost:8000

Note: If you have a 404, you'll may have to restart the nginx server:
`docker-compose stop nginx && docker-compose start nginx`
