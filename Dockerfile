FROM ruby:latest 
RUN apt-get update && apt-get install -y nodejs
RUN mkdir /myapp
COPY . /myapp
WORKDIR /myapp
RUN bundle
CMD bundle exec middleman server -e production
