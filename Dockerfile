FROM alpine:3.7
LABEL Author="IvanLu<me@ivanlu.cn>" Description="apache+php7 image"
LABEL maintainer="Ivan Lu<me@ivanlu.cn>" \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.name="Apache2 php7 on Alpine" \
    org.label-schema.url="https://os.twimi.cn" \
    org.label-schema.vcs-url="https://github.com/twimicn/docker-alpine-apache2-php7.git"
    
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --repository http://mirrors.aliyun.com/alpine/edge/community gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

# Setup apache and php
RUN apk --update add apache2 php7-apache2 curl \
    php7-json php7-phar php7-openssl php7-curl php7-mcrypt php7-pdo_mysql php7-ctype php7-gd php7-xml php7-dom php7-iconv php7-fileinfo php7-bcmath php7-bz2 php7-calendar php7-exif php7-gettext php7-gmp php7-imap php7-mbstring php7-session php7-simplexml php7-sockets php7-tokenizer php7-xmlreader php7-xmlrpc php7-xmlwriter php7-zip bash vim \
    && rm -f /var/cache/apk/* \
    && mkdir /run/apache2 \
    && mkdir -p /opt/utils  

EXPOSE 80

ADD start.sh /opt/utils/

RUN chmod +x /opt/utils/start.sh

ENTRYPOINT ["/opt/utils/start.sh"]
