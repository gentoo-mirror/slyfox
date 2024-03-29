# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="Quake III Arena - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="https://ioquake3.org/"
EGIT_REPO_URI="https://github.com/ioquake/ioq3.git"

LICENSE="GPL-2"
SLOT="0"

# "smp" is omitted, because currently it does not work.
IUSE="dedicated opengl teamarena +openal curl vorbis voice"

UIDEPEND="virtual/opengl
	media-libs/libsdl[sound,video,joystick,X,opengl]
	media-libs/libjpeg-turbo:0=
	openal? ( media-libs/openal )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
	voice? ( media-libs/speex )
	curl? ( net-misc/curl )
"
DEPEND="opengl? ( ${UIDEPEND} )
	!dedicated? ( ${UIDEPEND} )
"
RDEPEND="${DEPEND}"

my_arch() {
	case "${ARCH}" in
		x86)    echo "i386" ;;
		amd64)  echo "x86_64" ;;
		*)      tc-arch-kernel ;;
	esac
}

my_platform() {
	usex kernel_linux linux freebsd
}

src_prepare() {
	default

	tc-export CC
}

src_compile() {

	buildit() { use $1 && echo 1 || echo 0 ; }

	# Workaround for used zlib macro, wrt bug #449510
	append-flags -DOF=_Z_OF

	# OPTIMIZE is disabled in favor of CFLAGS.
	#
	# TODO: BUILD_CLIENT_SMP=$(buildit smp)
	emake \
		ARCH="$(my_arch)" \
		V=1 \
		BUILD_CLIENT=$(( $(buildit opengl) | $(buildit !dedicated) )) \
		BUILD_GAME_QVM=0 \
		BUILD_GAME_SO=0 \
		BUILD_SERVER=$(buildit dedicated) \
		DEFAULT_BASEDIR="${EPREFIX}/usr/$(get_libdir)/${PN}" \
		FULLBINEXT="" \
		GENERATE_DEPENDENCIES=0 \
		OPTIMIZE="" \
		PLATFORM="$(my_platform)" \
		TOOLS_CC="$(tc-getBUILD_CC)" \
		USE_CODEC_VORBIS=$(buildit vorbis) \
		USE_CURL=$(buildit curl) \
		USE_CURL_DLOPEN=0 \
		USE_INTERNAL_JPEG=0 \
		USE_INTERNAL_SPEEX=0 \
		USE_INTERNAL_ZLIB=0 \
		USE_LOCAL_HEADERS=0 \
		USE_OPENAL=$(buildit openal) \
		USE_OPENAL_DLOPEN=0 \
		USE_VOIP=$(buildit voice)
}

src_install() {
	dodoc ChangeLog id-readme.txt md4-readme.txt README.md TODO voip-readme.txt
	if use voice ; then
		dodoc voip-readme.txt
	fi

	if use opengl || ! use dedicated ; then
		doicon misc/quake3.svg
		make_desktop_entry ioquake3 "Quake III Arena"
		#use smp && make_desktop_entry quake3-smp "Quake III Arena (SMP)"
	fi

	cd build/release-$(my_platform)-$(my_arch) || die
	local exe
	for exe in ioquake3 ioquake3-smp ioq3ded ; do
		if [[ -x ${exe} ]] ; then
			dobin ${exe}
		fi
	done

	# Install renderer libraries, wrt bug #449510
	# this should be done through 'dogameslib', but
	# for this some files need to be patched
	exeinto "/usr/$(get_libdir)/${PN}"
	doexe renderer*.so
}
