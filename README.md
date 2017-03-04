Very basic Docker setup for Sylius
==================================

This is the most basic baseline setup I could've come up with for getting Sylius working locally via
Docker. It was tested extensively in Docker for Mac, but should technically work with other
installations.

Word of caution
---------------

This setup should be used as a baseline, not an end of itself. Please do not use it as is in
production as there are changes you are expected to do inside `Dockerfile` in order to secure your
code and data, particularly first lines of the file - environment variables.

Performance
-----------

Key reason for this repository was to find a way to make Sylius work under Docker for Mac with
minimum setup, but the best possible performance. This led to the setup you see in front of you. The
key difference from other `docker-compose.yml` setups I've seen is that I explicitly sync only the
folders I have or want to have control over locally:

```
- ./src:/app/src
- ./app:/app/app
- ./etc:/app/etc
- ./web:/app/web
- ./bin:/app/bin
- ./features:/app/features
- ./var/logs:/app/var/logs
```

This aleviates the need for Docker to sync thousands of files from your `cache` or `vendor` folders,
but forces you to rebuild your `web` container every time you add or remove a dependency. Which
I believe is a reasonable tradeoff.

Quirks
------

- Based on [`php-nginx`](https://github.com/continuouspipe/dockerfiles/tree/master/php-nginx) and [`symfony`](https://github.com/continuouspipe/dockerfiles/tree/master/symfony) containers
- Container environment is set to `dev`
- Accessing `/app_dev.php` is allowed by default
- HTTPS is enforced & certificate is automatically generated (configurable)
- `vendor/`, `node_modules/` and `var/cache` folders arent shared with the local system

Usage
-----

### Initial setup

```
> composer create-project -s beta sylius/sylius-standard acme
| database_host: mysql
| database_user: root
| database_password: root
> cd acme
> cp ../THIS-REPO/Dockerfile .
> cp ../THIS-REPO/docker-compose.yml .
> docker-compose up -d
> docker-compose run --rm web bin/console sylius:install
> docker-compose run --rm web npm run gulp
> open https://localhost/app_dev.php
```

### On `package.json` or `composer.json` update

```
> docker-compose up -d --build web
```
