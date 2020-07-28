function git.clean -d "Hard Reset of git changes as well as a clean of non tracked files"
    git reset --hard
    git clean -fx
end
