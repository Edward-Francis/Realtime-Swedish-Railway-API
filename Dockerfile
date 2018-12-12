FROM alpine:3.8

COPY cpanfile /

RUN apk add --update --no-cache --virtual=.build-dependencies build-base wget curl perl-dev \
    && apk add --update --no-cache perl \
    && curl --location --silent https://cpanmin.us | perl - App::cpanminus \
    && cpanm --installdeps . --from https://cpan.metacpan.org \
    && apk del .build-dependencies \
    && rm -rf /root/.cpanm/* /usr/local/share/man/*

CMD ["perl", "-MMojolicious::Lite", "-E", "get '/' =>sub { shift->render(text =>'OK!') }; app->start", "daemon"]
