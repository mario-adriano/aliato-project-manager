# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.5
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    libgmp-dev \
    libffi-dev \
    libreadline-dev \
    && rm -rf /var/lib/apt/lists/*

# Install je_malloc for better memory management
# RUN apt-get update && apt-get install --no-install-recommends -y libjemalloc2 && rm -rf /var/lib/apt/lists/*
# ENV LD_PRELOAD="libjemalloc.so.2" \
#     MALLOC_CONF="dirty_decay_ms:1000,narenas:2,background_thread:true,stats_print:false"
