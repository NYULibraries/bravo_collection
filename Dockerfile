FROM ruby:2.3.6

ENV INSTALL_PATH /app

# Essential dependencies
RUN apt-get update -qq && apt-get install -y build-essential vim mysql-client git wget

# Setup working directory
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Add github to known_hosts
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install gems in cachable way
COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy source into container
COPY . .
