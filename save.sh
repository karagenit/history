#!/usr/bin/env bash

DATE=`date '+%Y-%m-%d'`
NAME="${DATE}.txt"

mv -n "/home/caleb/.bash_history" "./data/${NAME}"
