FROM quay.io/continuouspipe/symfony-php7.1-nginx:stable

# Set environment variables and general build configuration
ARG SYMFONY_ENV=dev
ARG DEVELOPMENT_MODE=true
ENV SYMFONY_ENV $SYMFONY_ENV
ENV SYLIUS_APP_DEV_PERMITTED true

# Install NodeJS and NPM to allow assets building
RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -qq -y --no-install-recommends install \
    nodejs \
    npm \
 && apt-get auto-remove -qq -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/bin/nodejs /usr/bin/node

# Set up the default timezone for PHP
RUN echo "date.timezone = UTC" >> /etc/php/7.0/fpm/conf.d/docker.ini \
 && echo "date.timezone = UTC" >> /etc/php/7.0/cli/conf.d/docker.ini

# Copy the current directory, but wipe the cache
COPY . /app/
WORKDIR /app
RUN rm -rf var/cache/*

# Build environment and install dependencies
RUN container build
RUN npm install

# Rebuild autoloader without optimisation and clear the cache
RUN composer --no-interaction dump-autoload
RUN rm -rf var/cache/*
