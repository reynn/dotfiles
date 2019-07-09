#!/usr/bin/env python3

import click
import os

from pathlib import Path


@click.group()
def cli():
    pass


@cli.command()
@click.option('--depth', default=-1, help='Depth to traverse from base dir')
@click.option('--pattern', default='*', help='Filter out files')
@click.argument('base_path')
def get_files(depth, pattern, base_path):
    p = Path(base_path)
    max_length = len(p.absolute().parts) + int(depth)

    for filtered in sorted(p.rglob(pattern)):
        if depth != -1 and len(filtered.absolute().parts) > max_length:
            continue
        click.echo(filtered.absolute().relative_to(p.absolute()))


if __name__ == '__main__':
    cli()
