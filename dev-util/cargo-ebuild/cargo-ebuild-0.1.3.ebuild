# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.1.3

EAPI=6

CRATES="
advapi32-sys-0.1.2
aho-corasick-0.5.2
bitflags-0.1.1
cargo-0.10.0
cargo-ebuild-0.1.3
cmake-0.1.17
crates-io-0.2.0
crossbeam-0.2.9
curl-0.2.19
curl-sys-0.1.34
docopt-0.6.81
env_logger-0.3.3
filetime-0.1.10
flate2-0.2.14
fs2-0.2.5
gcc-0.3.28
gdi32-sys-0.2.0
git2-0.4.3
git2-curl-0.4.1
glob-0.2.11
idna-0.1.0
kernel32-sys-0.2.2
libc-0.2.13
libgit2-sys-0.4.3
libressl-pnacl-sys-2.1.6
libssh2-sys-0.1.37
libz-sys-1.0.4
log-0.3.6
matches-0.1.2
memchr-0.1.11
miniz-sys-0.1.7
nom-1.2.3
num_cpus-0.2.13
openssl-sys-0.7.14
pkg-config-0.3.8
pnacl-build-helper-1.4.10
rand-0.3.14
regex-0.1.73
regex-syntax-0.3.4
rustc-serialize-0.3.19
semver-0.2.3
strsim-0.3.0
tar-0.4.6
tempdir-0.3.4
term-0.4.4
thread-id-2.0.0
thread_local-0.2.6
time-0.1.35
toml-0.1.30
unicode-bidi-0.2.3
unicode-normalization-0.1.2
url-0.2.38
url-1.1.1
user32-sys-0.2.0
utf8-ranges-0.1.3
uuid-0.1.18
winapi-0.2.7
winapi-build-0.1.1
"

inherit cargo

DESCRIPTION="Generates an ebuild for a package using the in-tree eclasses."
HOMEPAGE="https://github.com/cardoe/cargo-ebuild"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	net-misc/curl:0=
	dev-libs/openssl:0=
	net-libs/http-parser:0=
	net-libs/libssh2:0=
	sys-libs/zlib:0=
"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}"/${P}-ebuild-header.patch)
