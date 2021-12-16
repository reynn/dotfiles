#!/usr/bin/env fish

function __get_random_name --description 'Get a random name from a list (similar to Docker et al.)'
    set -lx names Albedo Amber Barbara Beidou Bennett Chongyun Diluc Diona Eula Fischl Ganyu "Hu Tao"
    set -a names Jean Kazuha "Kaedehara Kaeya" "Ayaka Kamisato" Keqing Klee Lisa Mona Ningguang Noelle Qiqi Razor
    set -a names Rosaria Sayu Sucrose Tartaglia Venti Xiangling Xiao Xingqiu Xinyan Yanfei Yoimiya Zhongli

    set -l name_jsons 'https://raw.githubusercontent.com/alg-wiki/wikia/master/json/shiplist.json'

    set --append names (__get_json -- "$name_jsons" | dasel select -r json -m '.[*].name' --plain)

    echo (string lower (random choice $names)) | string replace --regex '\\s' -
end
