FROM ruby:2.6.2-alpine

ENV DOCKER true
ENV INSTALL_PATH /app
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV USER docker

ENV RUN_PACKAGES bash ca-certificates fontconfig git mariadb-dev nodejs nodejs-npm tzdata 
ENV BUILD_PACKAGES build-base curl curl-dev linux-headers ruby-dev wget

RUN addgroup -g 2000 $USER && \
    adduser -D -h $INSTALL_PATH -u 1000 -G $USER $USER

WORKDIR $INSTALL_PATH

# Install gems in cachable way
COPY Gemfile Gemfile.lock ./
RUN apk add --no-cache --update $BUILD_PACKAGES $RUN_PACKAGES
RUN wget --no-check-certificate -q -O - https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /tmp/wait-for-it.sh
RUN chown docker:docker /tmp/wait-for-it.sh && chmod a+x /tmp/wait-for-it.sh 
RUN gem install bundler -v '2.0.1' \
  && bundle config --local github.https true \
  && bundle install --without no_docker --jobs 20 --retry 5 \
  && chown -R docker:docker $BUNDLE_PATH

COPY --chown=docker:docker . .

USER $USER
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]