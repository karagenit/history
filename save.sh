#!/usr/bin/env bash

# Run Script from Real Script Location Always
cd "$(dirname "$(realpath "$0")")"

DATE=`date '+%Y-%m-%d %H:%M'`
NAME="${DATE}.txt"

mv -n "$HOME/.bash_history" "./data/${NAME}"
echo "Saved $HOME/.bash_history to ./data/${NAME}"
