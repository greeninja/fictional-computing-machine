FROM alpine:latest
RUN apk update && \
    apk add mariadb gcc make build-base ruby ruby-rdoc ruby-dev ruby-rake ruby-bundler git libffi mariadb-dev sqlite libxml2 sqlite-dev libffi-dev openjdk8 nodejs ruby-irb tzdata ruby-bigdecimal bash && \
    rm -rf /var/cache/apk/*
WORKDIR /home
ADD . /home
RUN chown 10000:100000 /home -R && \
    bundle install

EXPOSE 8080

ENTRYPOINT ["/home/docker-entrypoint.sh"]
