# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# ::slyfox note: forked ebuild to get live version. New upstream.
# Also fixes dwarf-5 generation on gcc-11: https://bugs.gentoo.org/768444

EAPI=8

inherit autotools git-r3 toolchain-funcs

DESCRIPTION="debug source path manipulation tool"
HOMEPAGE="https://www.sourceware.org/debugedit/"
EGIT_REPO_URI="https://sourceware.org/git/debugedit.git"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"

RDEPEND="dev-libs/elfutils:="
DEPEND="${RDEPEND}"

src_prepare() {
	default

	eautoreconf
}

src_test() {
	# debugedit's test suite relies on absolute paths
	# being written to debug sections. CCACHE_BASEDIR
	# makes them relative to increase cache hit. Let's
	# disable it.
	unset CCACHE_BASEDIR

	default
}
