# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mk-configure.eclass
# @MAINTAINER:
# Sergei Trofimovich <slyich@gmail.com>
# @BLURB: for mk-configure based build systems

inherit bmake

# @ECLASS-VARIABLE: MKCMAKE
# @DESCRIPTION:
# Specify alternative `mkcmake` binary.
: ${MKCMAKE:=mkcmake}

DEPEND="dev-util/mk-configure"

EXPORT_FUNCTIONS src_compile src_test src_install

# @FUNCTION: mk-configure_run_tool
# @USAGE: mk-configure_run_tool <bmake-arguments>
# @DESCRIPTION:
# this function will call ${BMAKE} with a set of standard
# variables already prefilled to make Gentoo packaging
# less repetitive.
mk-configure_run_tool() {
	local mkc_env_args=(
		STRIPFLAG=
	)
	BMAKE="${MKCMAKE}" bmake_run_tool "${mkc_env_args[@]}" "$@"
}

mk-configure_src_compile() {
	mk-configure_run_tool "$@"
}

mk-configure_src_test() {
	mk-configure_run_tool test "$@"
}

mk-configure_src_install() {
	mk-configure_run_tool DESTDIR="${D}" install "$@"
}
