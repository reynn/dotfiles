#!/usr/bin/env fish

function _tide_item_tab_rs
    set_color 'white'
    set -q TAB; and echo $TAB
end
set -xg CLOUDFLARE_API_EMAIL 'nic@reynn.dev'
set -xg CLOUDFLARE_API_KEY (bw get item Cloudflare | jq -r '.fields[] | select(.name == "API_KEY").value')
set -xg TRAEFIK_BASIC_USER_AUTH ''
set -xg CREDS_TORGUARD ''
