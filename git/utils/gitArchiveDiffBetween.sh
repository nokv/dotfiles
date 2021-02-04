#!/bin/sh
# $1 is newer than $2
# 特定のコミット間の差分をzip化
git archive --format=zip HEAD `git diff --name-only $2 $1 --diff-filter=ACMR` -o ../$1.zip
