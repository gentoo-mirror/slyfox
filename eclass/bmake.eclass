# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: bmake.eclass
# @MAINTAINER:
# Sergei Trofimovich <slyich@gmail.com>
# @BLURB: for bmake based build systems

inherit multiprocessing toolchain-funcs

# @ECLASS-VARIABLE: BMAKE
# @DESCRIPTION:
# Specify alternative `bmake` binary.
: ${BMAKE:=bmake}

# @ECLASS-VARIABLE: BMAKE_NOPARALLEL
# @DESCRIPTION:
# Disable automatic parallelism inference.
# Looks like mk-configure has parallelism problems.
: ${BMAKE_NOPARALLEL:=yes-it-is-broken}

# @ECLASS-VARIABLE: BMAKE_PREFIX
# @DESCRIPTION:
# Default prefix for bmake-based packages.
: ${BMAKE_PREFIX:=${EPREFIX}/usr}

# @ECLASS-VARIABLE: BMAKE_SYSCONFDIR
# @DESCRIPTION:
# Default config prefix for bmake-based packages.
: ${BMAKE_SYSCONFDIR:=${EPREFIX}/etc}

# @ECLASS-VARIABLE: BMAKE_MANDIR
# @DESCRIPTION:
# Default man prefix for bmake-based packages.
: ${BMAKE_MANDIR:=${BMAKE_PREFIX}/share/man}

# @ECLASS-VARIABLE: BMAKE_DOCDIR
# @DESCRIPTION:
# Default docs prefix for bmake-based packages.
: ${BMAKE_DOCDIR:=${BMAKE_PREFIX}/share/doc/${PF}}

DEPEND="sys-devel/bmake"

EXPORT_FUNCTIONS src_compile src_test src_install

# @FUNCTION: bmake_run_tool
# @USAGE: bmake_run_tool <bmake-arguments>
# @DESCRIPTION:
# this function will call ${BMAKE} with a set of standard
# variables already prefilled to make Gentoo packaging
# less repetitive.
bmake_run_tool() {
	local phase_env_args=(
		# bmake-based build systems are very sensitive
		# to external environment variables.
		# At least 'app-misc/runawk' is affected by FILESDIR
		-i
	)
	local job_args="-j $(makeopts_jobs)"

	phase_env_args+=(
		PREFIX="${BMAKE_PREFIX}"
		SYSCONFDIR="${BMAKE_SYSCONFDIR}"
		MANDIR="${BMAKE_MANDIR}"
		DOCDIR="${BMAKE_DOCDIR}"

		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		LD="$(tc-getLD)"
		USE_NM="$(tc-getNM)"

		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		PATH="${PATH}"

		CCACHE_DIR="${CCACHE_DIR}"
	)

	# at least bmake on mk-configure fails to parse '-j N install' commandline
	[[ -n ${BMAKE_NOPARALLEL} ]] && job_args=
	set -- env "${phase_env_args[@]}" ${BMAKE} ${job_args} "$@"
	echo "$@"
	"$@" || die
}

bmake_src_compile() {
	bmake_run_tool
}

bmake_src_test() {
	bmake_run_tool test
}

bmake_src_install() {
	bmake_run_tool DESTDIR="${D}" install
}
