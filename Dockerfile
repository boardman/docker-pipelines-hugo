FROM alpine:3.7
MAINTAINER Roger Boardman <roger@bxthree.com>

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python \
    py-pip \
    wget \
    git \
  && pip install --upgrade pip \
  && pip install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.34
ARG HUGO_SHA256=b9aa1d54e83daa1f77c0794110d2d96064bc07431337742fec903f65f0606e6e

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
