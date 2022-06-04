################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################
import os.path

from carbin.pkg.utils import share_dir, copy_dir
from string import Template


def install_cmake_template(prefix, verbose, pkg_name, force):
    print('cmake template install to', prefix, 'package name:', pkg_name)
    cmake_root = os.path.join(share_dir(), 'cmake')
    cmake_script = os.path.join(cmake_root, 'cmake')
    cmake_txt = os.path.join(cmake_root, 'CMakeLists.txt')
    dst_cmake_txt = os.path.join(prefix, 'CMakeLists.txt')
    cmake_copt = os.path.join(cmake_root, 'copts')
    cmake_conda = os.path.join(cmake_root, 'conda')
    copy_dir(cmake_script, os.path.join(prefix, 'cmake'), force, verbose)
    copy_dir(cmake_copt, os.path.join(prefix, 'copts'), force, verbose)
    copy_dir(cmake_conda, os.path.join(prefix, 'conda'), force, verbose)

    with open(cmake_txt, encoding="utf-8") as fp:
        cnt_str = fp.read()
        template = Template(cnt_str)
        ss = template.safe_substitute({"PNAME": pkg_name})
        with open(dst_cmake_txt, 'w+', encoding="utf-8") as dfp:
            dfp.write(ss)
            dfp.close()
        fp.close()
