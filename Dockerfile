FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
RUN > /myapp/Gemfile.lock && \
    bundle install
ADD . /myapp
