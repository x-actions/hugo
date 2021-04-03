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

RUN apk update && \
    apk add --no-cache bash wget curl git git-lfs openssh-client tree libstdc++ && \
    cd /tmp && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-bin-2.33-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-i18n-2.33-r0.apk  && \
    apk add glibc-2.33-r0.apk glibc-bin-2.33-r0.apk glibc-i18n-2.33-r0.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep hugo_extended | \
    sed -r -n '/browser_download_url/{/Linux-64bit.tar.gz/{s@[^:]*:[[:space:]]*"([^"]*)".*@\1@g;p;q}}' | xargs wget && \
    tar xzf *Linux-64bit.tar.gz -C /tmp && \
    mv /tmp/hugo /usr/bin && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
