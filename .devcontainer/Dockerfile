# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

RUN apt-get update && \
    apt-get install -y build-essential libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*
