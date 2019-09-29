FROM ubuntu:bionic

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGE_VERSION_URL=http://www.mysqueezebox.com/update/?version=7.9.2&revision=1&geturl=1&os=deb

RUN apt-get update && \
    apt-get -y install curl wget faad flac lame sox libio-socket-ssl-perl libcrypt-openssl-rsa-perl tzdata && \
    url=$(curl "$PACKAGE_VERSION_URL" | sed 's/_all\.deb/_amd64\.deb/') && \
    curl -Lsf -o /tmp/logitechmediaserver.deb $url && \
    dpkg -i /tmp/logitechmediaserver.deb && \
    rm -f /tmp/logitechmediaserver.deb && \
    apt-get -f install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Delete the user created by install. It will be recreated by the entrypoint
# with proper user and group id.
RUN userdel squeezeboxserver

VOLUME /music /config

EXPOSE 3443 3443/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh 
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
