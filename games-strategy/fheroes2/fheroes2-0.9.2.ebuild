# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="free implementation of Heroes of Might and Magic II game engine"
HOMEPAGE="https://ihhub.github.io/fheroes2/"

SRC_URI="https://github.com/ihhub/fheroes2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
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
	default

	sed 's/-O3//' -i src/Makefile || die

	append-cxxflags -DCONFIGURE_FHEROES2_DATA=\"${EPREFIX}$(fheroes2_datadir)\"

	tc-export AR CC CXX

	export WITHOUT_BUNDLED_LIBS=YES
	export FHEROES2_IMAGE_SUPPORT=YES

	# TODO: patch inplace
	export MAKEOPTS="${MAKEOPTS} AR=$(tc-getAR)"
}

src_compile() {
	emake
	emake -C files/lang
}

src_install() {
	dodoc doc/README.txt doc/README_PSV.md

	insinto $(fheroes2_datadir)/files/fonts
	doins files/fonts/*.ttf

	insinto $(fheroes2_datadir)/files/fonts
	doins files/fonts/*.ttf

	insinto $(fheroes2_datadir)/files/stats
	doins files/stats/*.xml

	domo files/lang/*.mo

	dobin fheroes2
}

pkg_postinst() {
	einfo "Howto:"
	einfo " - add 'ANIM', 'SOUNDS', 'MUSIC', 'FONTS' to ~/.local/share/fheroes2/files"
	einfo " - \$ cd ~/.local/share/fheroes2"
	einfo " - \$ fheroes2"
}
