# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3

DESCRIPTION="An unusual RTS with ncurses or SDL backend."
HOMEPAGE="https://a-nikolaev.github.io/curseofwar/"
EGIT_REPO_URI="https://github.com/a-nikolaev/curseofwar.git"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="sys-libs/ncurses:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-CC.patch
	"${FILESDIR}"/${P}-tinfo.patch
	"${FILESDIR}"/${P}-nogz.patch
	"${FILESDIR}"/${P}-no-changelog.patch
)

src_prepare() {
	default

	tc-export CC
	export PREFIX=${EPREFIX}/usr
}
