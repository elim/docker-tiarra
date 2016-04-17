FROM alpine

MAINTAINER Takeru Naito <takeru.naito@gmail.com>

RUN apk --update add perl ca-certificates wget make && \
    rm -rf /var/cache/apk/*

RUN wget -qO- https://cpanmin.us | perl - App::cpanminus && \
    cpanm HTTP::Request::Common && \
    rm -r ~/.cpanm

RUN mkdir /opt
WORKDIR   /opt

RUN wget https://bitbucket.org/topia/tiarra/get/full-history.tar.gz && \
    tar xzf full-history.tar.gz && \
    rm      full-history.tar.gz && \
    mv topia-tiarra* tiarra

RUN mkdir -p /srv/tiarra
VOLUME       /srv/tiarra
WORKDIR      /srv/tiarra

EXPOSE 6667

CMD ["/usr/bin/perl", "/opt/tiarra/tiarra"]
