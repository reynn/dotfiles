#!/usr/bin/fish

# --- git.clone ---

complete -c 'git.clone' -d 'repos' -l 'r' -s 'r'
complete -c 'git.clone' -d 'The base directory to store repositories' -l 'base-dir' -s 'b'
complete -c 'git.clone' -d 'Clone protocol, either HTTPS or SSH' -l 'protocol' -s 'p'
complete -c 'git.clone' -d 'GitHub host name, for using against enterprise GitHub' -l 'host' -s 'H'
complete -c 'git.clone' -d '`cd` into the directory after clone' -l 'cd' -s 'c'
