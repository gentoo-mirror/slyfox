# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="open-source engine for Heroes of Might and Magic III"
HOMEPAGE="https://vcmi.eu/"

#SRC_URI="https://github.com/vcmi/vcmi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/vcmi/vcmi"
LICENSE="GPL-2"
SLOT="0"

# missing files?
RESTRICT=test

RDEPEND="
	dev-lang/luajit
	>=dev-libs/boost-1.48:=
	dev-cpp/tbb
	dev-qt/qtcore:=
	dev-qt/qtgui:=
	dev-qt/qtnetwork:=
	dev-qt/qtwidgets:=
	media-video/ffmpeg:=
	media-libs/libsdl2:=
	media-libs/sdl2-image:=
	media-libs/sdl2-mixer:=
	media-libs/sdl2-ttf:=
	sys-libs/zlib:=[minizip]

"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/workaround-targets.patch
)

src_configure() {
	local mycmakeargs=(
		# Stole from debian/control. Defaults do not have
		# RPATH at all.
		-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON
		-DCMAKE_INSTALL_RPATH="${EPREFIX}"/usr/$(get_libdir)/vcmi

		-DENABLE_PCH=OFF
		-DENABLE_TEST=OFF
	)

	cmake_src_configure
}

pkg_postinst() {
	einfo "To start check out https://wiki.vcmi.eu/Installation_on_Linux#Automated_install"
	einfo "Howto:"
	einfo " - add 'Data', 'Maps', 'Mp3' to ~/.local/share/vcmi"
	einfo " - run 'vcmilauncher'"
}
