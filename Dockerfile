FROM alpine:3.23.3

LABEL maintainer="spaquet74@gmail.com" \
    version="2.3.4" \
    description="MailCatcher NG"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TIMEZONE="UTC" \
    MAIL_LIMIT=50

RUN apk add --no-cache --update ruby sqlite-libs libstdc++ libxml2 libxslt \
    && apk add --no-cache --virtual .build-deps ruby-dev make g++ sqlite-dev binutils libxml2-dev libxslt-dev patch \
    && gem install sqlite3 -v "~> 2.9" --no-document --platform=ruby -- --use-system-libraries \
    && gem install mailcatcher-ng -v "~> 1.5.2" --no-document \
    && find /usr/lib/ruby/gems/*/gems -name "*.so" -exec strip {} + \
    && find /usr/lib/ruby/gems/*/extensions -name "*.so" -exec strip {} + \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
    && find /usr/lib/ruby/gems/*/gems -name "ext" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "ports" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "spec" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "test" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "tests" -type d -exec rm -rf {} +

# Create non-root mailcatcher user
RUN addgroup -g 1000 mailcatcher && \
    adduser -D -u 1000 -G mailcatcher mailcatcher && \
    mkdir -p /home/mailcatcher/.mailcatcher && \
    chown -R mailcatcher:mailcatcher /home/mailcatcher

USER mailcatcher

EXPOSE 1025 1080

CMD ["sh", "-c", "mailcatcher --foreground --smtp-port=1025 --http-port=1080 --ip=0.0.0.0 --messages-limit=$MAIL_LIMIT --no-quit"]
