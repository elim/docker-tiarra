FROM alpine:3.4
MAINTAINER Takeru Naito <takeru.naito@gmail.com>

ENV TARBALL https://bitbucket.org/topia/tiarra/get/full-history.tar.gz

ENV APPDIR  /app
ENV WORKDIR /var/tiarra

RUN set -xe \
  && mkdir -p \
    $APPDIR \
    $WORKDIR \

  && apk add --no-cache \
    ca-certificates=20160104-r4 \
    perl=5.22.2-r0 \

  && apk add --no-cache \
    --virtual .builddeps \
      make=4.1-r1 \
      tar=1.29-r1 \
      wget=1.18-r0 \

  && wget -qO- https://cpanmin.us \
    | perl - App::cpanminus \
  && cpanm HTTP::Request::Common \
  && rm -r ~/.cpanm \

  && wget -qO- $TARBALL \
    | tar xzf - \
      --directory=$APPDIR \
      --strip-components=1 \

  && apk del --purge .builddeps

VOLUME  $WORKDIR
WORKDIR $WORKDIR

EXPOSE 6667

CMD ["/usr/bin/perl", "/app/tiarra"]
