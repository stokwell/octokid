FROM ruby:3.2.2-alpine

ENV BUNDLER_VERSION 2.4.19

RUN apk update && apk add --no-cache \
  build-base 

WORKDIR /octokid

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version "$BUNDLER_VERSION"

RUN bundle config set --local without 'development test' &&  bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4000"]
