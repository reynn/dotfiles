# pip fish completion start
function __fish_complete_pip
    set -x COMP_WORDS (commandline -o) ""
    set -x COMP_CWORD ( \
        math (contains -i -- (commandline -t) $COMP_WORDS)-1 \
    )
    set -x PIP_AUTO_COMPLETE 1
    string split \  -- (eval $COMP_WORDS[1])
end
complete -fa "(__fish_complete_pip)" -c pip
# pip fish completion end
