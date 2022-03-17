gsw () {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fcd() {
    local dir
    dir=$(fd . --type directory --max-depth 1 | fzf) &&
    cd "$dir"
}

# 隣のディレクトリに移動する
ncd() {
    local dir
    dir=$(fd . .. --type directory --max-depth 1 | fzf) &&
    cd $dir
}

gcd() {
    local dir
    dir=$(echo $GCD_PATH | tr ':' '\n'| fzf) &&
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

fadd() {
    local default
    default=$(git config --get delta.side-by-side)
    git config --local delta.side-by-side false
    unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs unbuffer git diff" | awk '{print $2}' | xargs git add
    git config --local delta.side-by-side $default
}