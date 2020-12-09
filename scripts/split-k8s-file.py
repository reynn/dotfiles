#!/usr/bin/env python3
import ruamel.yaml as yaml

from argparse import ArgumentParser
from pathlib import Path


def yaml_loader(yaml_file: Path, out_dir: Path):
    if not out_dir.is_dir():
        print(
            f"{out_dir.absolute()} is not a directory, " +
            "please provide a different path.")
        exit(1)
    try:
        with yaml_file.open('r') as stream:
            documents = yaml.load_all(stream, Loader=yaml.Loader)
            for document in documents:
                file_name = f"{document['kind'].lower()}-{document['metadata']['name']}.yaml"
                print(f"Creating file :: {file_name}.yaml")
                with (out_dir / Path(file_name)).open('w') as output:
                    yaml.dump(document, output)
    except yaml.YAMLError as out:
        print(out)


def main():
    parser = ArgumentParser()
    parser.add_argument('--file',
                        help='The original file containing the YAML to split')
    parser.add_argument('--out',
                        help='Directory to output files to, default is `.`',
                        default='.')
    args = parser.parse_args()

    if args.file is None or args.file == '':
        parser.print_help()
        exit(1)

    yaml_loader(Path(args.file), Path(args.out))


if __name__ == '__main__':
    main()
