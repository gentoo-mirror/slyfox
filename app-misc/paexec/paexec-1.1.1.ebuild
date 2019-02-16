# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit mk-configure

DESCRIPTION="Parallel executor"
HOMEPAGE="https://sourceforge.net/projects/paexec/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-misc/runawk"

RESTRICT=test # tests hang. missing tool?

src_compile() {
	mk-configure_src_compile WARNERR=no
}
