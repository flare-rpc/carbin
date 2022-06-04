################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################

from setuptools import setup
import os

_this_dir = os.path.dirname(os.path.abspath(__file__))
_readme_file = os.path.join(_this_dir, 'README.md')


def get_long_description():
    with open(_readme_file, 'rb') as f:
        return f.read().decode('utf-8')


packages = ['carbin', 'carbin.cmake', 'carbin.conda', 'carbin.pkg']

setup(
    name='carbin',
    version="0.1.2",
    description='Setuptools extension to build and package CMake projects.',
    long_description=get_long_description(),
    long_description_content_type="text/markdown",
    author='jeff.li',
    author_email='lijippy@163.com',
    license='Apache License 2.0',
    license_files=['LICENSE'],
    packages=packages,

    package_dir={'carbin': 'src/carbin'},
    package_data={str('carbin'): [
        'share/cmake/*',
        'share/cmake/cmake/*',
        'share/cmake/cmake/modules/*',
        'share/cmake/cmake/package/*',
        'share/cmake/cmake/recipes/*',
        'share/cmake/conda/*',
        'share/cmake/copts/*',
    ]},
    entry_points={
            'console_scripts': [
                'carbin = carbin.__main__:main',
            ]
        },
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Natural Language :: Chinese (Simplified)',
        'Natural Language :: Chinese (Traditional)',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: Apache Software License',
        'Topic :: Scientific/Engineering',
        'Topic :: Software Development',
        'Topic :: Software Development :: Libraries',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Topic :: Software Development :: Localization',
        'Topic :: Text Processing :: Linguistic',
    ],
    keywords=['carbin', 'cmake', 'conda', 'setuptools', 'pybind11', 'build']
)
