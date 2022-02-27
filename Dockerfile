FROM alpine:3.15
LABEL maintainer="spaquet74@gmail.com" \
      version="1.2" \
      description="Debug SMTP with style"

RUN apk add --no-cache ca-certificates openssl \
    ruby ruby-bigdecimal ruby-json sqlite-libs libstdc++

ARG MAILCATCHER_VERSION=0.8

RUN apk add --no-cache --virtual .build-deps \
        ruby-dev make g++ sqlite-dev \
        && gem install -v $MAILCATCHER_VERSION mailcatcher --no-ri --no-rdoc \
        && apk del .build-deps \
        && rm -rf /var/cache/apk/*

# smtp port & web port
EXPOSE 1025 1080

ENTRYPOINT ["mailcatcher", "--foreground"]
CMD ["--ip=0.0.0.0", "--smtp-port=1025", "--http-port=1080"]
