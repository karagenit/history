#!/usr/bin/env bash

# Counts the lines in .bash_history
unsaved=`wc -l ~/.bash_history 2>/dev/null`

# We get an error if .bash_history doesn't exist, so this handles that
if [ $? == 0 ]
then
    unsaved=`echo $unsaved | cut -f1 -d' '`
else
    unsaved=0
fi

echo "Currently $unsaved Unsaved Entries"
