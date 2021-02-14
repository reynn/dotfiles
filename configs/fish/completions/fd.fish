
# Completions for the global flags
complete -c fd -s H -l hidden -d 'Search hidden files and directories'
complete -c fd -s I -l no-ignore -d 'Do not respect .(git|fd)ignore files'
complete -c fd -s s -l case-sensitive -d 'Case-sensitive search'
complete -c fd -s i -l ignore-case -d 'Case-insensitive search'
complete -c fd -s g -l glob -d 'Glob-based search'
complete -c fd -s a -l absolute-path -d 'Show absolute instead of relative paths'
complete -c fd -s l -l list-details -d 'Use a long listing format with file metadata'
complete -c fd -s L -l follow -d 'Follow symbolic links'
complete -c fd -s p -l full-path -d 'Search full path'
complete -c fd -s 0 -l print0 -d 'Separate results by the null character'
complete -c fd -s h -l help -d 'Prints help information'
complete -c fd -s V -l version -d 'Prints version information'

# Completions for the global options
complete -c fd -r -s d -l max-depth -d 'Set maximum search depth'
complete -c fd -x -s t -d 'Filter by type' -a 'f d s e e s p'
complete -c fd -x -l type -d 'Filter by type' -a 'file directory symlink executable empty socket pipe'
complete -c fd -x -s e -l extension -d 'Filter by file extension'
complete -c fd -x -s x -l exec -d 'Execute a command for each search result'
complete -c fd -x -s X -l exec-batch -d 'Execute a command with all search results at once'
complete -c fd -x -s E -l exclude -d 'Exclude entries that match the given glob pattern'
complete -c fd -x -s c -l color -d 'When to use colors' -a 'never auto always'
complete -c fd -x -s S -l size -d 'Limit results based on the size of files.'
complete -c fd -l changed-within -d 'Filter by file modification time (newer than)'
complete -c fd -l changed-before -d 'Filter by file modification time (older than)'
