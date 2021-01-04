# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake git-r3

DESCRIPTION="real-time binaural sound generation library (vangers-friendly)"
HOMEPAGE="https://github.com/stalkerg/clunk"
#SRC_URI="https://github.com/stalkerg/clunk/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/stalkerg/clunk.git"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libsdl2"
DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare

	# install to ${libdir} instead of 'lib'
	sed -i CMakeLists.txt -e 's@DESTINATION lib)@DESTINATION '$(get_libdir)')@g' || die
}
