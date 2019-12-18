#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# GitHub functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

function gh_get_assets() {
  local owner=$1
  local repo=$2
  local host=${3:-api.github.com}

  if test -z $1; then
    print_usage_json "$0"
    return 0
  fi
  helpers gh get --owner $owner --host $host --repo $repo asset --all
}

# -----------------------------------------------------------------------------
# Git functions ---------------------------------------------------------------

function git_checkout_branch() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}
