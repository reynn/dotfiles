function permissions.change -d "Update file permissions and ownership"
    set -l permissions 'true'
    set -l owner 'false'

    getopts $argv | while read -l key value
        switch $key
            case p permissions
                set permissions 'false'
            case o owner
                set owner 'true'
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if test "$permissions" = 'true'
        chmod -R u=rwx,g=rw,o=rw ./*
    end
    if test "$owner" = 'true'
        chown -R (id -u):(id -g) ./*
    end
end
