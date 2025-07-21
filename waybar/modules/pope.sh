#!/usr/bin/env bash

now=$(date +'%H:%M')
if [[ "$now" == "21:37" ]]; then
  echo '{"text": " ", "class": "pope-active"}'
else
  echo '{"text": "", "class": "pope-inactive"}'
fi