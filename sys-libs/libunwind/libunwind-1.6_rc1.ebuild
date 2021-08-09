# Copyright 2005-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}
inherit autotools flag-o-matic libtool multilib-minimal

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="http://www.nongnu.org/libunwind/"
SRC_URI="https://github.com/libunwind/libunwind/releases/download/v${MY_PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0/8" # libunwind.so.8
#KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 -riscv -sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug debug-frame doc libatomic lzma static-libs zlib"

RESTRICT="test" # some tests are broken (toolchain version dependent, rely on external binaries)

# We just use the header from libatomic.
RDEPEND="
	lzma? ( app-arch/xz-utils[static-libs?,${MULTILIB_USEDEP}] )
	zlib? ( sys-libs/zlib[static-libs?,${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	libatomic? ( dev-libs/libatomic_ops[${MULTILIB_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/libunwind.h

	# see libunwind.h for the full list of arch-specific headers
	/usr/include/libunwind-aarch64.h
	/usr/include/libunwind-arm.h
	/usr/include/libunwind-hppa.h
	/usr/include/libunwind-ia64.h
	/usr/include/libunwind-mips.h
	/usr/include/libunwind-ppc32.h
	/usr/include/libunwind-ppc64.h
	/usr/include/libunwind-sh.h
	/usr/include/libunwind-tilegx.h
	/usr/include/libunwind-x86.h
	/usr/include/libunwind-x86_64.h
)

multilib_src_configure() {
	# --enable-cxx-exceptions: always enable it, headers provide the interface
	# and on some archs it is disabled by default causing a mismatch between the
	# API and the ABI, bug #418253
	# conservative-checks: validate memory addresses before use; as of 1.0.1,
	# only x86_64 supports this, yet may be useful for debugging, couple it with
	# debug useflag.
	ECONF_SOURCE="${S}" \
	ac_cv_header_atomic_ops_h=$(usex libatomic) \
	econf \
		--enable-cxx-exceptions \
		--enable-coredump \
		--enable-ptrace \
		--enable-setjmp \
		$(use_enable debug-frame) \
		$(use_enable doc documentation) \
		$(use_enable lzma minidebuginfo) \
		$(use_enable static-libs static) \
		$(use_enable zlib zlibdebuginfo) \
		$(use_enable debug conservative_checks) \
		$(use_enable debug)
}

multilib_src_compile() {
	# Bug 586208
	CCACHE_NODIRECT=1 default
}

multilib_src_test() {
	# Explicitly allow parallel build of tests.
	# Sandbox causes some tests to freak out.
	SANDBOX_ON=0 emake check
}

multilib_src_install_all() {
	find "${D}" -name "*.la" -type f -delete || die
}
