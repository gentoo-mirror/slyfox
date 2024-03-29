# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby27 ruby30 ruby31"

inherit ruby-single git-r3

DESCRIPTION="look for USEless EXports in object files"
HOMEPAGE="https://github.com/trofi/uselex/"
EGIT_REPO_URI="https://github.com/trofi/uselex.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${RUBY_DEPS}"

src_install() {
	dobin ${PN}.rb
}
