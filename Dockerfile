FROM ubuntu:bionic

ENV TZ=Europe/Berlin
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/de.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get update; \
	apt-get -y dist-upgrade; \
    apt-get -y --no-install-recommends install nginx php-fpm wget; \
	mkdir /opt/phantomjs; \
	mkdir /run/php; \
	rm /etc/nginx/sites-enabled/default

COPY ./includes/app/wrapper.php /opt/articlecapture/
COPY ./includes/app/render.js /opt/phantomjs/
COPY ./includes/docker/init.sh /opt/docker/init.sh
COPY ./includes/configs/nginx/default.conf /etc/nginx/sites-enabled/
COPY ./includes/configs/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./includes/configs/php-fpm/www.conf /etc/php/7.2/fpm/pool.d/
RUN cd /tmp; \
	wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2; \
	tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2; \
	mv /tmp/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /opt/phantomjs/; \
	rm -rf /tmp/phantomjs-2.1.1-linux-x86_64; \
	rm -rf /tmp/phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN chmod a+x /opt/docker/init.sh;chmod +x /opt/phantomjs/phantomjs
RUN chown -Rf www-data:www-data /opt/phantomjs;chown -Rf www-data:www-data /opt/articlecapture

ENTRYPOINT "/opt/docker/init.sh"