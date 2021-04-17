# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="open-source engine for Heroes of Might and Magic III"
HOMEPAGE="https://vcmi.eu/"

#SRC_URI="https://github.com/vcmi/vcmi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/vcmi/vcmi"
LICENSE="GPL-2"
SLOT="0"

# missing files?
RESTRICT=test

RDEPEND="
	>=dev-libs/boost-1.48:=
	sys-libs/zlib:=[minizip]
	media-video/ffmpeg:=
	media-libs/libsdl2:=
	media-libs/sdl2-image:=
	media-libs/sdl2-mixer:=
	media-libs/sdl2-ttf:=

"
DEPEND="${RDEPEND}"

pkg_postinst() {
	einfo "To start check out https://wiki.vcmi.eu/Installation_on_Linux#Automated_install"
	einfo "Howto:"
	einfo " - add 'Data', 'Maps', 'Mp3' to ~/.local/share/vcmi"
}
