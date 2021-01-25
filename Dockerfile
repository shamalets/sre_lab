FROM ruby:2.7.0
# We specify everything will happen within the /app folder inside the container

ARG BUNDLER_VERSION=2.2.6
ARG APP_HOME=/home/app

ENV BUNDLER_VERSION=${BUNDLER_VERSION} \ 
    APP_HOME=${APP_HOME}

WORKDIR ${APP_HOME}
# We copy these files from our current application to the /app container

# RUN apt-get update -qq && apt-get install -y --no-install-recommends curl libssl-dev git mysql-client pdftk redis-tools msmtp msmtp-mta imagemagick tzdata libfontconfig1 libxrender1
COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v ${BUNDLER_VERSION}
RUN bundle install

# We copy all the files from our current application to the /app container
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]