#!/usr/bin/env python3

import click
import json

from pathlib import Path


def get_tuple_length(tup) -> int:
    k = tup[0]
    v = tup[1]
    if type(v) is list:
        return [get_tuple_length(x) for x in list(v)]
    return len(str(k)) + len(str(v)) + 3


def get_tuple_key_length(tup) -> int:
    k = tup[0]
    v = tup[1]
    if type(v) is list:
        return [get_tuple_key_length(x) for x in list(v)]

    return len(str(k))


def flatten_lists(l):
    flat_list = []
    for sublist in l:
        if type(sublist) is list:
            for item in sublist:
                flat_list.append(item)
    return flat_list
    # return [item for sublist in l for item in sublist if type(item) is list else item]


@click.group()
def cli():
    pass


@cli.command()
@click.option('--function', help='Name of the function to print for')
@click.argument('json_file')
def print_table_from_json(json_file, function):
    def _print_border_line(n, l):
        print(n * l)

    def _print_header(n, l, hl):
        _print_title(n, hl)
        _print_border_line('-', l)

    def _print_title(t, l):
        print(f"{str(t[0]).title()}".ljust(l+1) + f"| {t[1]}")

    def _print_item(t, l):
        print(f"{str(t[0])} ".rjust(l+1) + f"| {t[1]}")

    j = Path(json_file)
    if not j.exists():
        print(f"Provided file [{json_file}] does not exist")
        exit(1)
    jm = dict(json.loads(j.read_text(encoding='utf-8')))
    m = jm.get(function)
    if m is None:
        print(f"> {function} not found in {json_file}")
        print(f"> Found {len(jm.keys())} functions")
        for f in jm.keys():
            print(f"> {f}")
        exit(1)
    lines = {
        'name': function,
        'description': m.get('description'),
        'usage': m.get('usage'),
    }
    if len(m.get('parameters')) > 0:
        lines['parameters'] = [(x.get('name'), x.get('description'))
                               for x in m.get('parameters')]
    if len(m.get('examples')) > 0:
        lines['examples'] = [(x.get('name'), x.get('description'))
                             for x in m.get('examples')]

    # lambda combines the lengths of both elements of a tuple
    line_length = max(flatten_lists(map(get_tuple_length, lines.items()))) + 1
    header_length = max(flatten_lists(
        map(get_tuple_key_length, lines.items())))

    _print_border_line('-', line_length)
    for k, v in lines.items():
        if type(v) is str:
            _print_header((k, v), line_length, header_length)
        if type(v) is list:
            _print_header((k, '-'*(line_length-header_length-3)),
                          line_length, header_length)
            for li in list(v):
                _print_item(li, header_length)
            _print_border_line('-', line_length)


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
