# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DISTUTILS_USE_SETUPTOOLS=bdepend

KEYWORDS="~amd64 ~x86"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

DESCRIPTION="Python client for Taskcluster"
HOMEPAGE="https://docs.taskcluster.net/docs"

LICENSE="MPL-2.0"
SLOT="0"
IUSE=""
