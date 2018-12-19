FROM alpine:3.8

COPY app/cpanfile /

RUN apk add --update --no-cache --virtual=.build-dependencies build-base wget curl perl-dev \
    && apk add --update --no-cache perl \
    && curl --location --silent https://cpanmin.us | perl - App::cpanminus \
    && cpanm --installdeps . --from https://cpan.metacpan.org \
    && apk del .build-dependencies \
    && rm -rf /root/.cpanm/* /usr/local/share/man/*

COPY app/ /opt/

WORKDIR /opt

CMD [ "/usr/local/bin/morbo", "./script/rsr" ]