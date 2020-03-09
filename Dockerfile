FROM ruby:2.6.5-buster

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  patch \
  ruby-dev \
  zlib1g-dev \
  liblzma-dev \
  libsqlite3-dev \
  nodejs \
  yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY . /application

WORKDIR /application

COPY Gemfile .
COPY Gemfile.lock .

RUN gem update bundler
RUN gem install nokogiri
RUN bundle install --jobs 5
RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:install:stimulus
RUN bundle exec rails stimulus_reflex:install
