# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

: ${CMAKE_MAKEFILE_GENERATOR=ninja}
PYTHON_COMPAT=( python3_{7..9} )
inherit cmake llvm python-single-r1 git-r3 toolchain-funcs

DESCRIPTION="Super-parallel Python port of the C-Reduce"
HOMEPAGE="https://github.com/marxin/cvise/"
#SRC_URI="https://github.com/marxin/cvise/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/marxin/cvise.git"

LICENSE="UoI-NCSA"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

LLVM_MAX_SLOT=12
DEPEND="
	|| (
		sys-devel/clang:12
		sys-devel/clang:11
		sys-devel/clang:10
	)
	<=sys-devel/clang-$(( LLVM_MAX_SLOT + 1 )):="
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pebble[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	')
	dev-util/unifdef
	sys-devel/flex"
BDEPEND="
	${PYTHON_DEPS}
	sys-devel/flex
	test? (
		$(python_gen_cond_dep '
			dev-python/pebble[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		')
	)"

llvm_check_deps() {
	has_version "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup() {
	python-single-r1_pkg_setup
	llvm_pkg_setup
}

src_prepare() {
	sed -i -e 's:-n auto::' -e 's:--flake8::' setup.cfg || die
	cmake_src_prepare

	# patch out hardcoded 'gcc' call
	sed \
		-e 's/gcc -c /'$(tc-getCC)' -c /' \
		-i tests/test_cvise.py || die
}

src_install() {
	cmake_src_install

	# By default cvise installs scripts with '#!/usr/bin/env python3'
	# shebang. That breaks cvise if active python does not match
	# python cvise was built against.
	python_doscript "${ED}"/usr/bin/cvise
	python_doscript "${ED}"/usr/bin/cvise-delta
}

src_test() {
	cd "${BUILD_DIR}" || die
	epytest
}
