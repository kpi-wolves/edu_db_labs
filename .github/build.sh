#!/usr/bin/env bash

set -e

git remote show

git fetch origin $2
git checkout $2

if [[ $1 != "master" ]]
then
  sed -i "s='/edu_db_labs/'='/edu_db_labs/$1/'=" docs/.vuepress/config.js
fi

npm ci
npm run docs:build
