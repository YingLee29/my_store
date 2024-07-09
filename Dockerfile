FROM ruby:3.0.0

ENV LANG=C.UTF-8 \
    TZ=Asia/Hanoi
ENV APP /my_store
ENV BUNDLE_VERSION 2.3.19

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client vim

RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

RUN gem install bundler --version "$BUNDLE_VERSION"
RUN gem update --system

RUN mkdir $APP
WORKDIR $APP
