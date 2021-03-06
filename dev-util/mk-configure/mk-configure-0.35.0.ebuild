# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bmake

DESCRIPTION="bmake-based Lightweight replacement for autotools"
HOMEPAGE="https://sourceforge.net/projects/mk-configure/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT=test # assumes DESTDIR=/ and PREFIX=/usr/local

RDEPEND="sys-devel/bmake
	x11-misc/makedepend
"
DEPEND="${RDEPEND}"

src_install() {
	bmake_run_tool DESTDIR="${D}" install
}
