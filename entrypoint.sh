#!/bin/bash
set -e

GITHUB_EMAIL=${GITHUB_EMAIL:-"me@xiexianbin.cn"}
GITHUB_USERNAME=${GITHUB_USERNAME:-"xiexianbin"}
HUGO_ARGS=${HUGO_ARGS:-""}
HUGO_THEME_URL=${HUGO_THEME_URL:-}

echo "## Check Package Version ##################"
bash --version
git version
git lfs version
hugo version

echo "## Init Git Config ##################"
if ! git config --get user.name; then
    git config --global user.name "${GITHUB_USERNAME}"
fi

if ! git config --get user.email; then
    git config --global user.email "${GITHUB_EMAIL}"
fi

echo "## Setup Deploy keys ##################"
mkdir /root/.ssh
ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

if [ X"$HUGO_THEME_URL" = X"" ]; then
  echo "## Skip hugo them clone ##################"
else
  echo "## Clone hugo theme ##################"
  cd themes
  git clone ${HUGO_THEME_URL}
  cd ..
fi

echo "## Build site ##################"
HUGO_ENV=production
hugo ${HUGO_ARGS}
ls -lhart ./public

echo "## Done. ##################"
