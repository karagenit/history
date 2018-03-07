#!/usr/bin/env bash

unsaved=`wc -l ~/.bash_history | cut -f1 -d' '`

echo "Currently $unsaved Unsaved Entries"
