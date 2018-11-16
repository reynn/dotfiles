#!/usr/bin/env python3
import shutil

from argparse import ArgumentParser
from pathlib import Path


def entrypoint():
	parser = ArgumentParser()
	parser.add_argument('-f', '--force', action='store_true', default=False)

	args = parser.parse_args()

	print('Setting up dotfiles...')
	home_dir = Path.home()
	files = list(Path('.').rglob('*.sh'))
	files.append(Path('.zshrc'))

	for f in files:
		abs_f = f.resolve()
		home_path = home_dir / f.name
		if home_path.exists() and args.force:
			print(f"Deleting {home_path} and linking to {abs_f}")
			home_path.unlink()
			home_path.symlink_to(abs_f)
		elif not home_path.exists():
			print(f"{home_path} does not exist, linking to {abs_f}")
			home_path.symlink_to(abs_f)
	print('Complete!')

if __name__ == '__main__':
	entrypoint()
