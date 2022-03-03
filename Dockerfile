FROM alpine:3.15
LABEL maintainer="spaquet74@gmail.com" \
    version="1.5" \
    description="Debug SMTP with style using mailcatcher"

# Mailcatcher version
ARG MAILCATCHER_VERSION=0.8.1

# Setting the environment defaults to en_US.UTF-8
# --message-limit default value is 50
ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TIMEZONE="UTC" \
    MAIL_LIMIT=50

RUN apk add --no-cache ca-certificates openssl \
    ruby ruby-bigdecimal ruby-json sqlite-libs libstdc++

RUN apk add --no-cache --virtual .build-deps \
    ruby-dev make g++ sqlite-dev \
    && gem install -v $MAILCATCHER_VERSION mailcatcher --no-document \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# expose smtp port & web port
EXPOSE 1025 1080

# launch mailcatcher as a foreground process
# Using sh to enable string interpolation
CMD ["sh", "-c", "mailcatcher --foreground --smtp-port=1025 --http-port=1080 --ip=0.0.0.0 --messages-limit=$MAIL_LIMIT"]
