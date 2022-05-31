#!/bin/sh
# 特定のコミットとHEADとの差分をzip化
git archive --format=zip HEAD $(git diff --name-only $@ HEAD --diff-filter=ACMR) -o ../$@.zip
