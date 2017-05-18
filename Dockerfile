FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential
# for postgres
RUN apt-get install -y libpq-dev postgresql-client vim
# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev
# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb
# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN bundle install
ADD . $APP_HOME
