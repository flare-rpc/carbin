################################################################
#
# Copyright (c) 2022, liyinbin
# All rights reserved.
# Author by liyibin (jeff.li)
#
#################################################################


import click, os, functools, sys
from carbin import __version__
from carbin.pkg.cmake import install_cmake_template
from carbin.pkg.pypkg import install_pypkg_template

aliases = {
    'rm': 'remove',
    'ls': 'list'
}


class AliasedGroup(click.Group):
    def get_command(self, ctx, cmd_name):
        rv = click.Group.get_command(self, ctx, cmd_name)
        if rv is not None:
            return rv
        if cmd_name in aliases:
            return click.Group.get_command(self, ctx, aliases[cmd_name])
        return None


@click.group(cls=AliasedGroup, context_settings={'help_option_names': ['-h', '--help']})
@click.version_option(version=__version__, prog_name='carbin')
@click.option('-p', '--prefix',  default='.', help='Set prefix used to for project')
@click.option('-v', '--verbose', is_flag=True, envvar='VERBOSE', help="Enable verbose mode")
@click.pass_context
def main(ctx, prefix, verbose):
    ctx.obj = {}
    if verbose: ctx.obj['VERBOSE'] = verbose
    if prefix: ctx.obj['PREFIX'] = prefix


@main.command(name='init')
@click.option('-p', '--prefix',  default='.', help='Set prefix used to for project')
@click.option('-n', '--pkgname',  default='carbin', help='Set pkg name for project project')
@click.option('-v', '--verbose', is_flag=True, envvar='VERBOSE', help="Enable verbose mode")
@click.option('-m', '--cmake', is_flag=True, required=True, default=True, help="Eable camke template install")
@click.option('-z', '--bazel', is_flag=True, required=True, default=False, help="Eable bazel template install")
@click.option('-b', '--blade', is_flag=True,  default=False, help="Eable blade template install")
@click.option('-k', '--pypkg', is_flag=True, default=True, help="Eable blade template install")
@click.option('-f', '--force', is_flag=True, default=False, help="Eable blade template install")
def init_command(prefix, pkgname, verbose, cmake, bazel, blade, pypkg, force):
    if cmake:
        install_cmake_template(prefix,verbose, pkgname, force)
    if bazel or blade:
        print('not supports now!')
    if pypkg:
        install_pypkg_template(prefix,verbose, pkgname)

    print(pkgname, "template installing done")


if __name__ == '__main__':
    main()
