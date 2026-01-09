FROM alpine:3.23.2

# Mailcatcher version
# Use --build-arg VERSION=... to override
# or `rake docker VERSION=...`
ARG MAILCATCHER_VERSION=0.10.0

# Label
LABEL maintainer="spaquet74@gmail.com" \
    version="1.9.1" \
    description="Debug emails with style using mailcatcher a super simple SMTP server which catches messages sent to it and displays them in a web interface" \
    org.label-schema.name="mailcatcher" \
    org.label-schema.version="${MAILCATCHER_VERSION}" \
    org.label-schema.license="MIT"

# Setting the environment defaults to en_US.UTF-8 and the timezone to UTC
# --message-limit default value is 50
ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TIMEZONE="UTC" \
    MAIL_LIMIT=50

RUN apk add --no-cache --update ruby sqlite-libs libstdc++ \
    && apk add --no-cache --virtual .build-deps ruby-dev make g++ sqlite-dev binutils \
    && gem install sqlite3 -v "~> 1.3" --no-document --platform=ruby -- --use-system-libraries \
    && gem install mailcatcher -v $MAILCATCHER_VERSION --no-document \
    && find /usr/lib/ruby/gems/*/gems -name "*.so" -exec strip {} + \
    && find /usr/lib/ruby/gems/*/extensions -name "*.so" -exec strip {} + \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
    && find /usr/lib/ruby/gems/*/gems -name "ext" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "ports" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "spec" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "test" -type d -exec rm -rf {} + \
    && find /usr/lib/ruby/gems/*/gems -name "tests" -type d -exec rm -rf {} +

# expose smtp port & web port
EXPOSE 1025 1080

# launch mailcatcher as a foreground process
# Using sh to enable string interpolation
CMD ["sh", "-c", "mailcatcher --foreground --smtp-port=1025 --http-port=1080 --ip=0.0.0.0 --messages-limit=$MAIL_LIMIT"]
