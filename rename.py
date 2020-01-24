from glob import glob
import argparse
import os
import pathlib
import string
import typing

def pad_zero(folder: str):
    pattern = '*.mp4'
    path = pathlib.Path(folder) / pattern

    for _path in glob(str(path)):
        path = pathlib.Path(_path)
        name = path.name
        f, s = name[:2]
        if f.isnumeric() and not s.isnumeric():
            new_name ='0' + name
            os.rename(path, path.parent / new_name)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('folder', nargs='?', default=os.getcwd())
    return parser.parse_args()

if __name__ == "__main__":
    opt =parse_args()
    pad_zero(opt.folder)
