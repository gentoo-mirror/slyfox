# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 llvm

DESCRIPTION="property based reducer for C/C++ programs"
HOMEPAGE="https://github.com/csmith-project/creduce"
EGIT_REPO_URI="https://github.com/csmith-project/creduce.git"

LICENSE="BSD-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

LLVM_MAX_SLOT=10

RDEPEND="
	>=dev-lang/perl-5.10.0
	dev-perl/Exporter-Lite
	dev-perl/File-Which
	dev-perl/Getopt-Tabular
	dev-perl/Regexp-Common
	dev-perl/TermReadKey
	sys-devel/clang:${LLVM_MAX_SLOT}
	sys-devel/llvm:${LLVM_MAX_SLOT}
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
"
