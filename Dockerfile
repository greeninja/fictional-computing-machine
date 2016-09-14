FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y mariadb ruby ruby-rdoc ruby-devel git mariadb-devel sqlite libxml2 sqlite-devel libffi-devel
WORKDIR /home
ADD /home/personal_git/fictional-computing-machine/ /home
RUN chown 10000:100000 /home -R && \
    bundle install

EXPOSE 8080

ENTRYPOINT ["/home/docker-entrypoint.sh"]
