FROM ruby:2.6.5-slim-buster

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  patch \
  ruby-dev \
  zlib1g-dev \
  liblzma-dev \
  libsqlite3-dev \
  nodejs \
  yarn

COPY . /application

WORKDIR /application

COPY Gemfile .
COPY Gemfile.lock .

RUN gem update bundler
RUN gem install nokogiri
RUN bundle install --jobs 5
