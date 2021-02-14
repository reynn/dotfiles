#!/usr/bin/env fish

function __get_random_name --description 'Get a random name from a list (similar to Docker et al.)'
    set -l name_jsons 'https://raw.githubusercontent.com/alg-wiki/wikia/master/json/shiplist.json'
    set -lx names (cat (__get_json -- "$name_jsons") | jq -r '.[].name')
    echo (string lower (random choice $names)) | string replace --regex '\\s' -
end
