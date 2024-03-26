#!/bin/bash

MESSAGE="Trigger commit from $0"
PREVIOUS_COMMIT=$(git rev-parse HEAD)
PREVIOUS_MESSAGE=$(git log --format=%s -n 1 "$PREVIOUS_COMMIT")
LAST_COMMIT_DATE_FILE=./LAST_COMMIT_DATE

date > "$LAST_COMMIT_DATE_FILE"

git add "$LAST_COMMIT_DATE_FILE"
git commit -m "$MESSAGE"

# Squash if the previous commit comes from this script
if echo $PREVIOUS_MESSAGE | grep -q "$MESSAGE"; then
    git reset --soft "$PREVIOUS_COMMIT"
    git commit -m "$MESSAGE"
fi

git push "https://${APP_SRE_BOT_PUSH_TOKEN}@github.com/app-sre/pipelines-test-container.git" main
