# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="free implementation of Heroes of Might and Magic II game engine"
HOMEPAGE="https://ihhub.github.io/fheroes2/"

EGIT_REPO_URI="https://github.com/ihhub/fheroes2"
#SRC_URI="https://github.com/ihhub/fheroes2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

RDEPEND="
	dev-games/libsmacker
	dev-libs/tinyxml:0=
	media-libs/libpng:0=
	media-libs/libsdl2:0=
	media-libs/sdl2-image:0=
	media-libs/sdl2-mixer:0=
	media-libs/sdl2-ttf:0=
	sys-libs/zlib:0=
"
DEPEND="${RDEPEND}"

fheroes2_datadir() {
	echo "/usr/share/${P}"
}

src_prepare() {
	cmake_src_prepare

	# As there is no transliteration passed
	# all russion strings get converted to
	# empty lines or newlines. Let's just
	# skip such localization.
	rm files/lang/ru.po || die
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_TINYXML=ON
		-DUSE_SYSTEM_TINYXML=ON
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	emake -C files/lang
}

src_install() {
	cmake_src_install
	dodoc docs/README.txt docs/README_PSV.md

	insinto $(fheroes2_datadir)/files/fonts
	doins files/fonts/*.ttf

	domo files/lang/*.mo
}

pkg_postinst() {
	einfo "Howto:"
	einfo " - add 'ANIM', 'SOUNDS', 'MUSIC', 'FONTS' to ~/.local/share/fheroes2/files"
	einfo " - \$ cd ~/.local/share/fheroes2"
	einfo " - \$ fheroes2"
}
