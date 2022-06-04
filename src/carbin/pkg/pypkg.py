
################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################

from carbin.pkg.utils import share_dir, copy_dir
import shutil
import os

def install_pypkg_template(prefix, verbose, pkg_name):
    sd = share_dir()
    shutil.copy2(os.path.join(sd,'cmake', 'setup.py.txt'), os.path.join(prefix, 'setup.py'))
    shutil.copy2(os.path.join(sd, 'cmake', 'setup.cfg'), os.path.join(prefix, 'setup.cfg'))
    shutil.copy2(os.path.join(sd, 'cmake', 'pyproject.toml'), os.path.join(prefix, 'pyproject.toml'))