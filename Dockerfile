FROM ruby:3.4 AS base

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs rclone uchardet

WORKDIR /usr/src/app
ENV BUNDLE_PATH /gems
ENV RUBYLIB /usr/src/app/lib
RUN gem install bundler

FROM base AS dev
RUN apt-get install -yqq --no-install-recommends less entr mariadb-client
ADD sql/*.sql /docker-entrypoint-initdb.d/

FROM mariadb:10.5 AS prod
ADD sql/*.sql /docker-entrypoint-initdb.d/

LABEL org.opencontainers.image.source https://github.com/hathitrust/db-image
