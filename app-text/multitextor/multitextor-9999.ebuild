# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake git-r3

DESCRIPTION=" Multiplatform command line text editor."
HOMEPAGE="https://github.com/vikonix/multitextor"
EGIT_REPO_URI="https://github.com/vikonix/multitextor.git"

LICENSE="BSD-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

# TODO: unbundle libraries from 'ThirdParty'
RDEPEND="
	sys-libs/gpm:=
	sys-libs/ncurses:=
"
DEPEND="${RDEPEND}"
