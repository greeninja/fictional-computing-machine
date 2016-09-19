FROM ubuntu:latest
RUN apt update && \
    apt install -y mysql-client ruby ruby-dev gcc make automake libxml2 libmysqlclient-dev libsqlite3-dev openjdk-8-jdk ruby-execjs vim && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /home
ADD . /home
RUN gem install bundler && \
    /usr/local/bin/bundle install && \
    chown 100000:100000 /home -R

EXPOSE 8080

ENTRYPOINT ["/home/docker-entrypoint.sh"]
