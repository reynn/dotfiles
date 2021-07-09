#!/usr/bin/env fish

function os.update -d "Run os updates for various types of systems"
    set -x current_platform (uname | string lower)

    function __update_linux_system
        set release (cat /etc/*release* | string replace --regex --filter '^ID\=(.+)' '$1')
        __log "Running updates for Linux ($release)"
        switch $release
            case fedora centos
                sudo dnf update -y; and sudo dnf autoremove -y
            case debian ubuntu
                sudo apt update -y; and sudo apt upgrade -y; and sudo apt autoremove
        end
    end

    function __update_mac_system
        __log "Running updates for OS X"
    end

    switch $current_platform
        case linux
            __update_linux_system
        case darwin mac
            __update_mac_system
    end
end
