# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

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

	# disable dwarf-5 tests until https://sourceware.org/PR28161 is fixed
	export ac_cv_gdwarf_5=no

	eautoreconf
}
