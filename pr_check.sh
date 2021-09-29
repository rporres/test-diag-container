#!/bin/bash
set -exv
docker build  --no-cache \
              --force-rm \
              -t rporresm-test-diag-container:latest  \
              -f ./Dockerfile .
