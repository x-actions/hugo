# reate by xiexianbin, Github Action for Build Hugo site 
FROM ubuntu:20.04

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
LABEL "Version"="1.1.0"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ADD entrypoint.sh /
RUN apt update && \
    apt install -y bash wget curl git git-lfs openssh-client tree && \
    cd /tmp && \
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep hugo_extended | \
    sed -r -n '/browser_download_url/{/linux-amd64.tar.gz/{s@[^:]*:[[:space:]]*"([^"]*)".*@\1@g;p;q}}' | xargs wget --no-check-certificate -t3 -T2 && \
    tar xzf *linux-amd64.tar.gz -C /tmp && \
    mv /tmp/hugo /usr/bin && \
    apt-get clean && \
    rm -rf /tmp/* && \
    chmod +x /entrypoint.sh

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
