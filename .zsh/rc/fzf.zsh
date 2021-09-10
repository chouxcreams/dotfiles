gsw () {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

# 隣のディレクトリに移動する
ncd() {
    local dir
    dir=$(ls -d ../*/ | fzf)
    cd $dir
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
gsfr() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
