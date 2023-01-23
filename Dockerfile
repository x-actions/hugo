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
LABEL "Version"="1.1.0"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apk update && \
    apk add --no-cache bash wget curl git git-lfs openssh-client tree libc6-compat libstdc++ libstdc++6 && \
    cd /tmp && \
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep hugo_extended | \
    grep "Linux-64bit.tar.gz" | grep browser_download_url | awk -F "\"" '{print $4}' | xargs wget --no-check-certificate -t3 -T2 && \
    tar xzf *Linux-64bit.tar.gz -C /tmp && \
    mv /tmp/hugo /usr/bin && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
