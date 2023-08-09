#!/usr/bin/env zsh

# git add and commit
# 引数にはコミットメッセージを入れる
gac() {
    git add . && git commit -m "$1"
}

# git add, commit and push
# 引数にはコミットメッセージを入れる
gacp() {
    branch=`git rev-parse --abbrev-ref HEAD`
    git add . && git commit -m "$1" && git push -u origin "$branch"
}
