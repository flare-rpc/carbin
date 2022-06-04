################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################


import os
import shutil


def share_dir():
    _this_dir = os.path.dirname(os.path.abspath(__file__))
    _share_dir = os.path.join(_this_dir, '..', 'share')
    return os.path.abspath(_share_dir)


def mkdir(p):
    if not os.path.exists(p):
        os.makedirs(p)
    return p


def copy_dir(src, dst, force, verbose):
    for root, dirs, files in os.walk(src):
        for file in files:
            path = os.path.relpath(root, src)
            if path == '.':
                path = ''
            d = os.path.join(dst, path)
            mkdir(d)
            df = os.path.join(d, file)
            if os.path.exists(df) and not force:
                if verbose:
                    print("file:", df, "exists and be skip")
                continue
            sf = os.path.join(root, file)
            shutil.copy2(sf, df)
            if verbose:
                print("file:", sf, "copy tp ->", df)
