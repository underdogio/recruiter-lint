FROM ruby:2.3.1-alpine

RUN apk add --no-cache nodejs openjdk7-jre g++ musl-dev make

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

EXPOSE 3000
CMD ["bundle", "exec", "thin", "start"]
