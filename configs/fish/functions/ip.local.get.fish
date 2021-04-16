#!/usr/bin/env fish

function ip.local.get -d "Get the local IP address"
    if test -x (command -s ipconfig)
        ipconfig getifaddr en0
    else
        hostname -I
    end
end
