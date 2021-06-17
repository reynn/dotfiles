#!/usr/bin/env fish

function file.extract -d 'Extract a file [Port of OpenZSH extract plugin]'
    set -x archive_file
    set -x extract_destination

    function ___usage -d 'Show usage'
        set -l help_args -a "Extract a file [inspired by OpenZSH extract plugin]"

        set -a help_args -f "d|dest or destination|The target directory to extract files to|$extract_destination"

        set -a help_args -e " example.zip"
        set -a help_args -e " -d (mktemp -d) example.zip"

        __dotfiles_help $help_args
    end

    function ___extract
        set -l file "$argv[1]"
        set -l target_dir "$argv[2]"

        set -l extension ''

        switch $extension
            case .tar.gz .tgz
                tar zxvf "$file"
            case .tar.bz2 .tbz .tbz2
                tar xvjf "$file"
            case .tar.xz .txz
                tar --xz --help &>/dev/null && tar --xz -xvf "$file" || xzcat "$file" | tar xvf -
            case .tar.zma .tlz
                tar --lzma --help &>/dev/null && tar --lzma -xvf "$file" || lzcat "$file" | tar xvf -
            case .tar.zst .tzst
                tar --zstd --help &>/dev/null && tar --zstd -xvf "$file" || zstdcat "$file" | tar xvf -
            case .tar
                tar xvf "$file"
            case .tar.lz
                tar xvf "$file"
            case .tar.lz4
                lz4 -c -d "$file" | tar xvf -
            case .tar.lrz
                lrzuntar "$file"
            case .gz
                gunzip -k "$file"
            case .bz2
                bunzip2 "$file"
            case .xz
                unxz "$file"
            case .lrz
                lrunzip "$file"
            case .lz4
                lz4 -d "$file"
            case .lzma
                unlzma "$file"
            case .z
                uncompress "$file"
            case .zip .war .jar .sublime-package .ipsw .xpi .apk .aar .whl
                unzip "$file" -d $target_dir
            case .rar
                unrar x -ad "$file"
            case .7z
                7za x "$file"
            case .zst
                unzstd "$file"
            case '*'
                log fatal ''
        end
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set archive_file "$value"
            case d dest destination
                set destination "$value"
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

    ___extract $archive_file $extract_destination
end
