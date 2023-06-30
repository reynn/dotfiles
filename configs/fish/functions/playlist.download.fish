#!/usr/bin/env fish

function playlist.download -d "Downloads files from a m3u8 playlist and combines them into a single output file"
    set resolution "720"

    function ___usage
        set -l help_args -a "Downloads files from a m3u8 playlist and combines them into a single output file"

        set -a help_args -f "p|kubeconfig-path|The path containing potential Kubeconfig files|$kubeconfig_path"
        set -a help_args -f "k|kubeconfig|What to set KUBECTX variable to, as well as where to look for contexts|$kubeconfig_file"
        set -a help_args -f "K|no-kubeconfig|Remove the default and search ~/.kube for files|$no_kubeconfig_file"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case p playlist
                set -x playlist $value
            case O output
                set -x output_file $value
            case R resolution
                set resolution $value
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

    if test -z $output_file
      __log error "Output file must be provided"
      return 1
    end
    if test -z $playlist
      __log error "Must provide a playlist to download"
      return 1
    end
    set playlist_tmp_dir (mktemp -d)
    set playlist_tmp_file $playlist_tmp_dir/playlist.m3u8
    set playlist_base (string split / -r -m1 $playlist | head -1)
    __log debug "resolution       : $resolution"
    __log debug "playlist_tmp_file: $playlist_tmp_file"
    set desired_resolution_playlist (curl -SsL $playlist | grep $resolution --after-context=1 | tail -1)
    set resolution_playlist "$playlist_base/$desired_resolution_playlist"
    __log debug "resolution_playlist: $resolution_playlist"
    curl -SsL -o $playlist_tmp_file $resolution_playlist
    rm -f $output_file
    set -l chunks (cat $playlist_tmp_file | string match -a -r '.+\.ts$')
    __log "Downloading $(count $chunks) chunks from the playlist to $output_file"
    for line in $chunks
      set -l file_number (string match -g -r '.+_(\d+)\.ts$' $line)
      __log debug " >> Downloading part $file_number..."
      curl -SsL "$playlist_base/$line" >> $output_file
      if test -z "$DEBUG"
        printf '.'
      end
    end
    if test -z "$DEBUG"
      printf '\n'
    end
    __log debug " >> All parts downloaded"
end
