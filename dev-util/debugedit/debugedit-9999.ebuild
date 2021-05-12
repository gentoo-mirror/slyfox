# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{2..4} )

inherit autotools git-r3 lua-single

DESCRIPTION="Stand-alone debugedit from RPM"
HOMEPAGE="https://rpm.org
	https://github.com/rpm-software-management/rpm"
EGIT_REPO_URI="https://github.com/rpm-software-management/rpm.git"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"

RDEPEND="
	sys-libs/zlib:=
	>=dev-libs/popt-1.7
	>=dev-libs/elfutils-0.176-r1
	dev-libs/openssl:=
	${LUA_DEPS}
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	default

	eautoreconf

	# provide <rpm/*.h> headers. Existings file
	# depends are incomplete to Just Work.
	mkdir rpm || die
	find -name '*.h' -exec cp {} rpm/ ';' || die

}

src_configure() {
	append-cppflags -I"${EPREFIX}/usr/include/nss" -I"${EPREFIX}/usr/include/nspr"
	local myconf=(
		# force linking to static librpmio
		--disable-shared

		# disable linking compression libraries
		ac_cv_header_bzlib_h=no
		ac_cv_header_lzma_h=no
		--disable-zstd

		# fake some libraries we don't use
		ac_cv_header_magic_h=yes
		ac_cv_lib_magic_magic_open=yes

		# use openssl as crypto provider
		--with-crypto=openssl

		# disable other stuff irrelevant to debugedit
		--disable-nls
		--disable-plugins
		--disable-python
		--without-acl
		--without-archive
		--without-cap
		--without-selinux
	)
	econf "${myconf[@]}"
}

src_compile() {
	emake -C misc
	emake -C luaext
	emake -C rpmio
	emake debugedit
}

src_test() {
	:
}

src_install() {
	dobin debugedit
}
