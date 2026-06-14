#!/bin/bash

mkdir -p /logs/verifier

# ubuntu:24.04 has no python3; install it at verify time (kept out of the
# Dockerfile so the image build stays FROM + COPY only).
if ! command -v python3 >/dev/null 2>&1; then
  apt-get update -qq && apt-get install -y -qq python3 >/dev/null 2>&1
fi

cp /logs/check_result.json /logs/verifier/check_result.json 2>/dev/null

if python3 /tests/validate.py /logs/verifier/check_result.json; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
