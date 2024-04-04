#!/bin/bash

set -euo pipefail

MESSAGE="Trigger commit from $0"
PREVIOUS_COMMIT=$(git rev-parse HEAD)
PREVIOUS_MESSAGE=$(git log --format=%s -n 1 "$PREVIOUS_COMMIT")
LAST_COMMIT_DATE_FILE=./LAST_COMMIT_DATE
BRANCH=main
REPOSITORY="https://${APP_SRE_BOT_PUSH_TOKEN}@github.com/app-sre/pipelines-test-container.git"

git checkout "$BRANCH"
git pull "$REPOSITORY" "$BRANCH"

date > "$LAST_COMMIT_DATE_FILE"

git add "$LAST_COMMIT_DATE_FILE"
git commit -m "$MESSAGE"

# Squash if the previous commit comes from this script
if echo $PREVIOUS_MESSAGE | grep -q "$MESSAGE"; then
    git reset --soft $(git rev-parse HEAD~2)
    git commit -m "$MESSAGE"
fi

git push -f "$REPOSITORY" "$BRANCH"
