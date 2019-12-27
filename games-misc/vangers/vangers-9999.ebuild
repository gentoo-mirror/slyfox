# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils git-r3

DESCRIPTION="Video game combines elements of the racing and role-playing genres."
HOMEPAGE="https://github.com/KranX/Vangers"
#SRC_URI="https://github.com/stalkerg/clunk/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/KranX/Vangers.git"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-games/clunk:0=
	media-libs/libsdl2:0=
	media-libs/libvorbis:0=
	media-libs/sdl2-net:0=
	media-video/ffmpeg:0=
	sys-libs/zlib:0=
"
DEPEND="${RDEPEND}"

src_install() {
	dobin "${BUILD_DIR}"/src/vangers
}
