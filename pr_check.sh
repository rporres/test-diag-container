#!/bin/bash
set -exv
docker build  --no-cache \
              --force-rm \
              -t pipelines-test-container:latest  \
              -f ./Dockerfile .
