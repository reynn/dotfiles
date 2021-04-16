#!/usr/bin/env fish

function ip.remote.get -d "Get the remote IP address"
    dig +short myip.opendns.com @resolver1.opendns.com
end
