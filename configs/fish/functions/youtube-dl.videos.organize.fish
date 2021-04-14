function youtube-dl.videos.organize
    set -lx base_directory /media/deadpool/music_videos

    function ___usage
        __dotfiles_help $help_args
    end

    set -lx json_files (fd --type f --extension json)

    getopts $argv | while read -l key value
        switch $key
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

end
