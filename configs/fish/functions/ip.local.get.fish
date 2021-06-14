#!/usr/bin/env fish

function ip.local.get -d "Get the local IP address"
    if command.is_available -c ipconfig
        ipconfig getifaddr en0
    else
        hostname -I
    end
end
