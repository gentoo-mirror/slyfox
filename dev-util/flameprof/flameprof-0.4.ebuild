# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_IN_SOURCE_BUILD=1
inherit distutils-r1

KEYWORDS="~amd64 ~x86"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

DESCRIPTION="cProfile flamegraph generator"
HOMEPAGE="https://github.com/baverman/flameprof/"

LICENSE="MIT"
SLOT="0"
IUSE=""

# TODO: 'flameprof' shell script does not rout to correct python implementation
