#!/bin/bash

github_username="BubbleNeumann"
github_token=""

git config credential.helper "store --file=.git/credentials"
echo "https://$github_username:$github_token@github.com" > .git/credentials

git push
