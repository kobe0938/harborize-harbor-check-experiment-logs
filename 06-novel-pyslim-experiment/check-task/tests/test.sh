#!/bin/bash

# python:3.13-slim already has python3, so no apt install needed here.
mkdir -p /logs/verifier

cp /logs/check_result.json /logs/verifier/check_result.json 2>/dev/null

if python3 /tests/validate.py /logs/verifier/check_result.json; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
