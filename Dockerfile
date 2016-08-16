FROM alpine:latest
RUN apk update && \
    apk add mariadb gcc make build-base ruby ruby-rdoc ruby-dev ruby-rake ruby-bundler git libffi mariadb-dev sqlite libxml2 sqlite-dev libffi-dev openjdk8 nodejs ruby-irb tzdata ruby-bigdecimal && \
    rm -rf /var/cache/apk/*
WORKDIR /home
ADD . /home
RUN bundle install

EXPOSE 8080:8080

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]
