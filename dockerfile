FROM    --platform=$TARGETOS/$TARGETARCH php:8.2.25-apache

LABEL org.opencontainers.image.source="https://github.com/la-banquise/osticket-docker"

COPY php.ini /usr/local/etc/php/

RUN 	apt-get update \
		&& apt-get upgrade

RUN		apt-get install -y git multitail nano
RUN		git clone https://github.com/osTicket/osTicket \
		&& cd osTicket \
		&& git switch 1.17.x \
		&& php manage.php deploy --setup /var/www/html
#apk add --update git \
#		&& apk add --update bash \
#		&& apk add --update php-8.2 \
#		&& rm -rf /var/cache/apk/* \
#		&& adduser -D container
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions gd xdebug mysqli imap intl apcu opcache

#USER        container
#ENV         USER=container HOME=/home/container
#WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
