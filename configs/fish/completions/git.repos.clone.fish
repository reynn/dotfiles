#!/usr/bin/fish

# --- git.repos.clone ---

complete -c 'git.repos.clone' -d 'repos' -l 'r' -s 'r'
complete -c 'git.repos.clone' -d 'The base directory to store repositories' -l 'base-dir' -s 'b'
complete -c 'git.repos.clone' -d 'Clone protocol, either HTTPS or SSH' -l 'protocol' -s 'p'
complete -c 'git.repos.clone' -d 'GitHub host name, for using against enterprise GitHub' -l 'host' -s 'H'
complete -c 'git.repos.clone' -d '`cd` into the directory after clone' -l 'cd' -s 'c'
