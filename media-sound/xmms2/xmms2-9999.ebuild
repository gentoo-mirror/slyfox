# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils python git

DESCRIPTION="X(cross)platform Music Multiplexing System. The new generation of the XMMS player."
HOMEPAGE="http://xmms2.xmms.org"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"

EGIT_REPO_URI=git://git.xmms.se/xmms2/xmms2-devel
EGIT_PROJECT=xmms2-devel

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="aac airplay +alsa ao asf avahi cdda curl cxx ffmpeg flac gvfs ices
jack mac mlib-update mms +mp3 mp4 modplug mpg123 musepack ofa oss
perl phonehome pulseaudio python ruby
samba +server sid speex +vorbis vocoder wavpack xml"

RDEPEND="server? (
		>=dev-db/sqlite-3.3.4

		aac? ( >=media-libs/faad2-2.0 )
		airplay? ( dev-libs/openssl )
		alsa? ( media-libs/alsa-lib )
		ao? ( media-libs/libao )
		avahi? ( net-dns/avahi )
		cdda? ( >=media-libs/libdiscid-0.1.1
			>=media-sound/cdparanoia-3.9.8 )
		curl? ( >=net-misc/curl-7.15.1 )
		ffmpeg? ( media-video/ffmpeg )
		flac? ( media-libs/flac )
		gvfs? ( gnome-base/gnome-vfs )
		ices? ( media-libs/libogg
			media-libs/libshout
			media-libs/libvorbis )
		jack? ( >=media-sound/jack-audio-connection-kit-0.101.1 )
		mac? ( media-sound/mac )
		mms? ( media-video/ffmpeg
			>=media-libs/libmms-0.3 )
		modplug? ( media-libs/libmodplug )
		mp3? ( media-sound/madplay )
		mp4? ( >=media-libs/faad2-2.0 )
		mpg123? ( >=media-sound/mpg123-1.5.1 )
		musepack? ( media-sound/musepack-tools )
		ofa? ( media-libs/libofa )
		pulseaudio? ( media-sound/pulseaudio )
		samba? ( net-fs/samba[smbclient] )
		sid? ( media-sound/sidplay
			media-libs/resid )
		speex? ( media-libs/speex
			media-libs/libogg )
		vorbis? ( media-libs/libvorbis )
		vocoder? ( sci-libs/fftw media-libs/libsamplerate )
		wavpack? ( media-sound/wavpack )
		xml? ( dev-libs/libxml2 )
	)

	>=dev-libs/glib-2.12.9
	cxx? ( >=dev-libs/boost-1.32 )
	mlib-update? ( app-admin/gamin )
	perl? ( >=dev-lang/perl-5.8.8 )
	python? ( >=dev-python/pyrex-0.9.5.1 )
	ruby? ( >=dev-lang/ruby-1.8.5 ) "

DEPEND="${RDEPEND}
	>=dev-lang/python-2.4.3"

S=${WORKDIR}/xmms2-devel

# use_enable() is taken as proto
# $1 - useflag
# $2 - xmms2 option/plugin name (equals to $1 if not set)

xmms2_flag() {
	if [[ -z "$1" ]]; then
		echo "!!! xmms2_flag() called without a parameter." >&2
		echo "!!! xmms2_flag() <USEFLAG> [<xmms2_flagname>]" >&2
		return 1
	fi

	local UWORD=${2:-$1}

	case "$1" in
		ENABLED)
			echo ",${UWORD}"
			;;
		DISABLED)
			: # nothing is generated
			;;
		*)
			if use "$1"; then
				echo ",${UWORD}"
			else
				: # nothing is generated
			fi
			;;
	esac
	return 0
}

src_configure() {
	# ./configure alike options.
	local waf_params="--without-ldconfig \
			--prefix=/usr \
			--libdir=/usr/$(get_libdir) \
			--destdir="${D}" \
			${CTARGET:+--with-target-platform=${CTARGET}} \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--datadir=/usr/share \
			--sysconfdir=/etc \
			--localstatedir=/var/lib"

	local optionals=""
	local plugins=""
	if ! use server ; then
		waf_params+=" --without-xmms2d"
	else
		# some fun static mappings:
		local option_map=(	# USE		# sorted xmms2 option flag (same, as USE if empty)
					"avahi		avahi"
					"ENABLED	cli"
					"avahi		dns_sd"
					"phonehome	et"
					"ENABLED	launcher"
					"mlib-update	medialib-updater"
					"ENABLED	nycli"
					"		perl"
					"ENABLED	pixmaps"
					"		python"
					"		ruby"
					"DISABLED	tests"
					"DISABLED	vistest"
					"cxx		xmmsclient++"
					"cxx		xmmsclient++-glib"
					"DISABLED	xmmsclient-cf"
					"DISABLED	xmmsclient-ecore" # not in tree
				)

		local plugin_map=(	# USE		# sorted xmms2 plugin flag (same, as USE if empty)
					"		alsa"
					"		airplay"
					"		ao"
					"ffmpeg		apefile"
					"ffmpeg		avcodec"
					"		asf"
					"ENABLED	asx"
					"		cdda"
					"DISABLED	coreaudio" # MacOS only?
					"		curl"
					"ENABLED	cue"
					"avahi		daap"
					"ENABLED	diskwrite"
					"ENABLED	equalizer"
					"aac		faad"
					"ENABLED	file"
					"		flac"
					"ffmpeg		flv"
					"ffmpeg		tta"
					"DISABLED	gme" # not in tree
					"		gvfs"
					"ENABLED	html"
					"		ices"
					"ENABLED	icymetaint"
					"ENABLED	id3v2"
					"		jack"
					"ENABLED	karaoke"
					"ENABLED	m3u"
					"		mac"
					"		mms"
					"mp3		mad"
					"		mp4"
					"		mpg123"
					"		modplug"
					"		musepack"
					"DISABLED	nms" # not in tree
					"ENABLED	normalize"
					"ENABLED	null"
					"ENABLED	nulstripper"
					"		ofa"
					"		oss"
					"ENABLED	pls"
					"pulseaudio	pulse"
					"ENABLED	replaygain"
					"xml		rss"
					"		samba"
					"DISABLED	sc68" #not in tree
					"		sid"
					"		speex"
					"DISABLED	sun" # {Open,Net}BSD only
					"DISABLED	tremor" # not in tree
					"		vorbis"
					"		vocoder"
					"ffmpeg		tta"
					"ENABLED	wave"
					"DISABLED	waveout" # windows only
					"		wavpack"
					"xml		xspf"
					"ENABLED	xml"
				)

		for option in "${option_map[@]}"; do
			optionals+="$(xmms2_flag $option)"
		done

		for plugin in "${plugin_map[@]}"; do
			plugins+="$(xmms2_flag $plugin)"
		done
	fi # ! server

	# pass them explicitely even if empty as we try to avoid magic deps
	waf_params+=" --with-optionals=${optionals:1}" # skip first ',' if yet
	waf_params+=" --with-plugins=${plugins:1}"

	"${S}"/waf ${waf_params} configure || die "'waf configure' failed"
}

src_compile() {
	"${S}"/waf build || die "waf build failed"
}

src_install() {
	"${S}"/waf --destdir="${D}" install || die "'waf install' failed"
	dodoc AUTHORS TODO README

	use python && python_need_rebuild
}

pkg_postinst() {
	elog "This version is built on experimental development code"
	elog "If you encounter any errors report them at http://bugs.xmms2.xmms.se"
	elog "and visit #xmms2 at irc://irc.freenode.net"
	if use phonehome ; then
		einfo ""
		einfo "The phone-home client xmms2-et was activated"
		einfo "This client sends anonymous usage-statistics to the xmms2"
		einfo "developers which may help finding bugs"
		einfo "Disable the phonehome useflag if you don't like that"
	fi

	use python && python_mod_optimize $(python_get_sitedir)/xmmsclient
}

pkg_postrm() {
	use python && python_mod_cleanup $(python_get_sitedir)/xmmsclient
}
