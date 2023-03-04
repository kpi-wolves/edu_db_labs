#!/usr/bin/env bash

GITHUB_API="https://api.github.com/repos/kpi-wolves/edu_db_labs"

pull_requests=$(curl -s -H "Authorization: $AUTH" $GITHUB_API/pulls?state=open)
master_sha=$(curl -s -H "Authorization: $AUTH" $GITHUB_API/git/ref/heads/master | jq -r ".object.sha")
prs=$(echo $pull_requests | jq -c ". | map({number: .number, sha: .head.sha}) + [{number: \"master\", sha: \"$master_sha\"}]")
echo $prs
echo "pull_requests=$prs" > $GITHUB_OUTPUT
