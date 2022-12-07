#!/usr/bin/env fish

function __get_random_name
    # list of Genshin Impact characters
    set names Albedo Aloy Amber "Arataki Itto" Barbara Beidou Bennett Candace Chongyun Collei Cyno
    set -a names Diluc Diona Dori Eula Fischl Ganyu Gorou "Hu Tao" Jean "Kaedehara Kazuha" Kaeya "Kamisato Ayaka" "Kamisato Ayato"
    set -a names Keqing Klee "Kujou Sara" "Kuki Shinobu" Layla Lisa Mona Nahida Nilou Ningguang Noelle Qiqi "Raiden Shogun"
    set -a names Razor Rosaria "Sangonomiya Kokomi" Sayu Shenhe "Shikanoin Heizou" Sucrose Tartaglia Thoma Tighnari Traveler
    set -a names "Lumine" Venti Xiangling Xiao Xingqiu Xinyan "Yae Miko" Yanfei Yelan Yoimiya "Yun Jin" Zhongli
    set -a names Dainsleif Faruzan Wanderer

    # get a list of boats from Azur Lane
    set name_jsons 'https://raw.githubusercontent.com/alg-wiki/wikia/master/json/shiplist.json'
    set --append names (__get_json "$name_jsons" | dasel -w plain -r json '.all().name')

    echo (string lower (random choice $names)) | string replace --regex '\\s' -
end
