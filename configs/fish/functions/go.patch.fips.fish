#!/usr/bin/env fish

function go.patch.fips -d "Create a dummy src package for fips to fix building on osx"
    set -l go_fips_src_root "$GOROOT/src/crypto/tls/fipsonly"
    mkdir -v $go_fips_src_root
    echo "package fipsonly" > "$go_fips_src_root/fipsonly.go"
    if test "$argv[1]" = '-v'
        log.info -m 'Fips package contents `'(cat "$go_fips_src_root/fipsonly.go")'`'
    end
end
