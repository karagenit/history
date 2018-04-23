#!/usr/bin/env bash

DATE=`date '+%Y-%m-%d %H:%M'`
NAME="${DATE}.txt"

mv -n "$HOME/.bash_history" "./data/${NAME}"
