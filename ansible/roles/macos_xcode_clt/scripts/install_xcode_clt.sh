#!/bin/bash

sleep 10

softwareupdate -l

XCLT=$(softwareupdate -l |
grep "\*.*Command Line" |
head -n 1 | awk -F"Label: " '{print $2}' |
tr -d '\n')

if [ -z "$XCLT" ]; then
  echo "Xcode CLT not found"
else
  sudo softwareupdate -i "$XCLT"
fi
