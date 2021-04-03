# reate by xiexianbin, Github Action for Build Hugo site 
FROM alpine:latest

# Dockerfile build cache 
ENV REFRESHED_AT 2020-01-11

LABEL "com.github.actions.name"="Github Action for Build Hugo site"
LABEL "com.github.actions.description"="Github Action for Build Hugo site."
LABEL "com.github.actions.icon"="home"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/x-actions/hugo"
LABEL "homepage"="http://github.com/x-actions/hugo"
LABEL "maintainer"="xiexianbin<me@xiexianbin.cn>"

LABEL "Name"="Github Action for Build Hugo site"
LABEL "Version"="1.0.0"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apk update && apk add --no-cache git git-lfs bash wget curl openssh-client tree && rm -rf /var/cache/apk/*

RUN mkdir /usr/local/hugo/ && \
    cd /usr/local/hugo/ && \
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | \
    grep hugo_extended | \
    sed -r -n '/browser_download_url/{/Linux-64bit.tar.gz/{s@[^:]*:[[:space:]]*"([^"]*)".*@\1@g;p;q}}' | xargs wget && \
    tar xzf *Linux-64bit.tar.gz -C /usr/local/hugo/ && \
    ln -s /usr/local/hugo/hugo /usr/local/bin/hugo && \
    rm *Linux-64bit.tar.gz

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
