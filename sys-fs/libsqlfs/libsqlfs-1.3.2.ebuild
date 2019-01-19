# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="sqlite-backed FUSE filesystem"
HOMEPAGE="https://github.com/guardianproject/libsqlfs"
SRC_URI="https://github.com/guardianproject/libsqlfs/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Sandbox fails 'opendir(.)'. TODO: add a bug link.
RESTRICT=test

DEPEND="
	dev-db/sqlite:3=
	sys-fs/fuse:0=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-no-werror.patch
)

src_prepare() {
	default

	# 1. upstream does not ship ./configure. Only configure.in.
	# 2. we patch configure.in to disable -Werror
	eautoreconf
}
