FROM ubuntu:16.04
MAINTAINER gc (gc@techbanx.com)

ENV PHALCON_VERSION=3.3.2
ENV NGINX_VERSION=1.13.12
ENV PHP_VERSION=7.0
ENV TZ=America/Montreal
############################################################
### Basics + install of usefull tools
############################################################
USER root
# Update
RUN apt-get update && apt-get -y upgrade
# Basics tools
RUN apt-get -y install apt-utils curl vim net-tools supervisor \
                       software-properties-common libfontconfig1 \
                       ca-certificates apt-transport-https language-pack-en-base

# timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
############################################################
### Install of nginx
############################################################
RUN curl -s https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo "deb https://nginx.org/packages/mainline/ubuntu/ xenial nginx" > /etc/apt/sources.list.d/nginx.list
RUN apt-get update && apt-get install -y nginx=${NGINX_VERSION}-1~xenial
# nginx conf main file
ADD config/nginx/nginx.conf /etc/nginx/nginx.conf
# Default nginx conf for app
ADD config/nginx/default.conf /etc/nginx/conf.d/default.conf
# create folder for app
RUN mkdir -p /var/www/html/application
# create folder for log with permission
RUN mkdir -p /var/log/nginx && chmod -R 777 /var/log/nginx
############################################################
### Install of php7.x-fpm + php modules
############################################################
# fix utf-8 issue with ppa:ondrej/php
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get update

# php7.x-fpm + php modules
RUN apt-get -y install php${PHP_VERSION}-fpm \
                       php${PHP_VERSION}-dev php${PHP_VERSION}-mysql php${PHP_VERSION}-common php${PHP_VERSION}-xml \
                       php${PHP_VERSION}-curl php${PHP_VERSION}-json php${PHP_VERSION}-gd php${PHP_VERSION}-opcache \
                       php${PHP_VERSION}-zip php${PHP_VERSION}-xsl php${PHP_VERSION}-mbstring \
                       php${PHP_VERSION}-mcrypt php-apcu

# php config php.ini
ADD config/php/php.ini /etc/php/7.0/fpm/php.ini

# php config php-fpm
ADD config/php/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf

# php config pool.d
ADD config/php/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf

############################################################
### Install of phalcon
############################################################
RUN apt-get install -y libpcre3-dev gcc make re2c

RUN cd /opt && curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && tar xzf /opt/v${PHALCON_VERSION}.tar.gz
RUN cd /opt/cphalcon-${PHALCON_VERSION}/build/ && ./install

RUN echo "; configuration for phalcon framework" > /etc/php/${PHP_VERSION}/mods-available/phalcon.ini
RUN echo "; priority=20" >> /etc/php/${PHP_VERSION}/mods-available/phalcon.ini
RUN echo "extension=phalcon.so" >> /etc/php/${PHP_VERSION}/mods-available/phalcon.ini

RUN phpenmod phalcon
############################################################
### Start services / use of supervisord
############################################################
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY application /var/www/html/application
RUN chmod -R 777 /var/www/html/application && mkdir -p /var/run/php
EXPOSE 80
CMD ["/usr/bin/supervisord"]
