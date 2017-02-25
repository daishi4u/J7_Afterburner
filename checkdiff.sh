#!/bin/bash
if [ -z "$1" ];
then
    echo "usage: $0 number_of_commits"
    exit 1
fi
git diff --name-only HEAD~$1 HEAD
