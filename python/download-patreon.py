#!/usr/bin/env python3
import json
import os

import requests
from requests.auth import HTTPBasicAuth
from urllib.parse import urlencode, urlparse, parse_qs
from argparse import ArgumentParser
from pathlib import Path


def remove_query(url) -> str:
    u = urlparse(url)
    query = parse_qs(u.query)
    query.pop('token-time', None)
    query.pop('token-hash', None)
    u = u._replace(query=urlencode(query, True))
    return u.geturl()


def get_img_out_path(u: str, base_path: Path) -> Path:
    url = remove_query(u)
    ext = url[url.rfind('.')+1:]
    usplit = url.split('/')
    return base_path / f"{usplit[-2]}.{ext}"


def download_image(image_url: str, download_path: Path):
    print(f'Downloading {image_url} to {download_path}')
    try:
        img_data = requests.get(image_url, auth=HTTPBasicAuth(
            'arasureynn@gmail.com', 'Wo9JVlNqx6WSeo7P')).content
        with download_path.open(mode='wb') as df:
            df.write(img_data)
        return None
    except OSError as err:
        print(f"Cannot download file: {err}")
        return err
    except ValueError as verr:
        print(f"Cannot download file: {verr}")
        return verr


def entry_point():
    parser = ArgumentParser(description='')
    parser.add_argument('--out', '-o', required=True)
    parser.add_argument('--json', '-j', required=True)
    args = parser.parse_args()

    out_path = Path(args.out)
    json_file = Path(args.json)
    json_dict = []
    if json_file.exists() and json_file.is_file():
        with json_file.open(mode='r') as jf:
            json_dict = json.loads(jf.read())
    if not out_path.exists():
        out_path.mkdir(parents=True)
    for post in json_dict:
        post_dict = dict(post)
        imgs = list(post_dict.get("imgs"))
        id = post_dict.get('id')
        title = post_dict.get('title')
        content = post_dict.get('content')
        attachments = post_dict.get('attachments')
        lines = [
            f'ID: {id}',
            f'Title: {title}',
            f'Content: {content}',
            f'Attachments: {attachments}'
        ]
        if imgs:
            post_folder = out_path / id
            post_folder.mkdir(exist_ok=True)
            with (post_folder / 'post.md').open(mode='w') as pfs:
                pfs.write('\n'.join(lines))
            for img in imgs:
                img_out_path = get_img_out_path(img, post_folder)
                download_image(img, img_out_path)
            # if attachments:
            #     print('----- Downloading attachments')
            #     for attach in attachments:
            #         sp = attach.split('|')
            #         download_image(sp[0], post_folder / sp[1])
        # if attachments:
        #     post_folder = out_path / id
        #     post_folder.mkdir(exist_ok=True)
        #     for attach in attachments:
        #         sp = attach.split('|')
        #         download_image(sp[0], post_folder / sp[1])
        else:
            o = out_path / f'{id.split("/")[-1]}.md'
            with o.open(mode='w') as pfs:
                pfs.write('\n'.join(lines))


if __name__ == '__main__':
    entry_point()
