#!/usr/bin/env fish

function file.extract -d 'Extract a file [Port of OpenZSH extract plugin]'
    set -x archive_file
    set -x extract_destination

    function ___usage -d 'Show usage'
        set -l help_args -a "Extract a file [inspired by OpenZSH extract plugin]"

        set -a help_args -f "a|archive|The archive to extract|$archive_file"
        set -a help_args -f "d|dest or destination|The target directory to extract files to|$extract_destination"

        set -a help_args -e " example.zip"
        set -a help_args -e " -d (mktemp -d) example.zip"

        __dotfiles_help $help_args
    end

    function ___extract
        switch $archive_file
            case "*.tar.gz" "*.tgz"
                __log debug 'case "*.tar.gz" "*.tgz"'
                set extract_cmd tar zxvf "$archive_file"
                if test -n "$extract_destination"
                    set -a extract_cmd -C $extract_destination
                end
                __log debug "extract_cmd: [$extract_cmd]"
                $extract_cmd 2>/dev/null
            case "*.tar.bz2" "*.tbz" "*.tbz2"
                __log debug 'case "*.tar.bz2" "*.tbz" "*.tbz2"'
                set extract_cmd tar xvjf "$archive_file"
                if test -n "$extract_destination"
                    set -a extract_cmd -C $extract_destination
                end
                __log debug "extract_cmd: [$extract_cmd]"
                $extract_cmd 2>/dev/null
            case "*.tar.xz" "*.txz"
                __log debug "branch: case *.tar.xz *.txz"
                tar --xz --help &>/dev/null && tar --xz -xvf "$archive_file" || xzcat "$archive_file" | tar xvf -
            case "*.tar.zma" "*.tlz"
                __log debug "branch: case *.tar.zma *.tlz"
                tar --lzma --help &>/dev/null && tar --lzma -xvf "$archive_file" || lzcat "$archive_file" | tar xvf -
            case "*.tar.zst" "*.tzst"
                __log debug "branch: case *.tar.zst *.tzst"
                tar --zstd --help &>/dev/null && tar --zstd -xvf "$archive_file" || zstdcat "$archive_file" | tar xvf -
            case "*.tar"
                __log debug 'case "*.tar"'
                set extract_cmd tar xvf "$archive_file"
                if test -n "$extract_destination"
                    set -a extract_cmd -C $extract_destination
                end
                __log debug "extract_cmd: [$extract_cmd]"
                $extract_cmd 2>/dev/null
            case "*.tar.lz"
                __log debug 'case "*.tar.lz"'
                set extract_cmd tar xvf "$archive_file"
                if test -n "$extract_destination"
                    set -a extract_cmd -C $extract_destination
                end
                __log debug "extract_cmd: [$extract_cmd]"
                $extract_cmd 2>/dev/null
            case "*.tar.lz4"
                __log debug "branch: case *.tar.lz4"
                lz4 -c -d "$archive_file" | tar xvf -
            case "*.tar.lrz"
                __log debug "branch: case *.tar.lrz"
                lrzuntar "$archive_file"
            case "*.gz"
                __log debug "branch: case *.gz"
                gunzip -k "$archive_file"
            case "*.bz2"
                __log debug "branch: case *.bz2"
                bunzip2 "$archive_file"
            case "*.xz"
                __log debug "branch: case *.xz"
                unxz "$archive_file"
            case "*.lrz"
                __log debug "branch: case *.lrz"
                lrunzip "$archive_file"
            case "*.lz4"
                __log debug "branch: case *.lz4"
                lz4 -d "$archive_file"
            case "*.lzma"
                __log debug "branch: case *.lzma"
                unlzma "$archive_file"
            case "*.z"
                __log debug "branch: case *.z"
                uncompress "$archive_file"
            case "*.zip" "*.war" "*.jar" "*.sublime-package" "*.ipsw" "*.xpi" "*.apk" "*.aar" "*.whl"
                __log debug 'case "*.zip" "*.war" "*.jar" "*.sublime-package" "*.ipsw" "*.xpi" "*.apk" "*.aar" "*.whl"'
                set extract_cmd unzip "$archive_file"
                if test -z "$extract_destination"
                    set -a extract_cmd -d "$extract_destination"
                end
                __log debug "extract_cmd: [$extract_cmd]"
                $extract_cmd
            case "*.rar"
                __log debug "branch: case *.rar"
                unrar x -ad "$archive_file"
            case "*.7z"
                __log debug "branch: case *.7z"
                7za x "$archive_file"
            case "*.zst"
                __log debug "branch: case *.zst"
                unzstd "$archive_file"
            case '*'
                __log fatal "File $archive_file does not match an expected extension"
                return 1
        end
    end

    getopts $argv | while read -l key value
        switch $key
            case a archive
                set archive_file "$value"
            case d dest destination
                set extract_destination "$value"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    if test -z $archive_file
        __log error "Cannot proceed without providing a file to extract"
        return 1
    end

    __log debug "archive_file         : $archive_file"
    __log debug "extract_destination  : $extract_destination"

    ___extract $archive_file $extract_destination
end
