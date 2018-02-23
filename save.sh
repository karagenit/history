#!/usr/bin/env bash

DATE=`date '+%Y-%m-%d %H:%M'`
NAME="${DATE}.txt"

mv -n "/home/caleb/.bash_history" "/home/caleb/documents/programming/src/history/data/${NAME}"
