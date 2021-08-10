slyfox's ebuild overlay
-----------------------

This is an overlay for my personal hacks. These are:

- new ebuilds: small tools, ancient games
- fixes for existing ::gentoo ebuilds

It should be safe to use this overlay on a day-to-day basis
in stable or ~arch systems. Most suspicious ebuilds are
unkeyworded (these are usually prerelreases).

How to use
----------

First, let's enable the overlay. We can either use the
eselect-repository method::

    # Install eselect-repository if you don't already have it
    emerge app-eselect/eselect-repository
    # Fetch and output the list of overlays
    eselect repository list
    eselect repository enable slyfox

or we can use the layman method::
  
    # Add important USE flags for layman to your package.use directory:
    echo "app-portage/layman sync-plugin-portage git" >> /etc/portage/package.use/layman
    # Install layman if you don't already have it
    emerge app-portage/layman
    # Rebuild layman's repos.conf file:
    layman-updater -R
    # Add the Gentoo Haskell overlay:
    layman -a slyfox

Finally, we need to unmask the overlay (this does not apply if your system
is already running ~arch)::
    # Unmask ~testing versions for your arch:
    echo "*/*::slyfox ~$(portageq envvar ARCH)" >> /etc/portage/package.accept_keywords

No big things
-------------

I would like to keep the overlay safe to use for everyone.
If it gets out of hands I'll try to fork off big things
to other overlays. The candidates are:

- ::haskell: https://github.com/gentoo-haskell/gentoo-haskell/
- ::nix-guix: https://github.com/trofi/nix-guix-gentoo/

How to evaluate deviations
--------------------------

Forked ::gentoo ebuilds have a few things to make syncing with
::gentoo easier:

- latest copy of gentoo ebuild is available as is to ease diffing
- forked ebuild has a `::slyfox note:`

Let's looks at the `sys-apps/texinfo-6.8-r1` as an example:

It's based on `sys-apps/texinfo-6.8` and has a note. We can diff it as:

.. code-block:: diff

    $ diff -u texinfo-6.8.ebuild texinfo-6.8-r1.ebuild
    --- texinfo-6.8.ebuild  2021-07-03 18:44:03.846641906 +0100
    +++ texinfo-6.8-r1.ebuild       2021-08-10 08:10:48.309274822 +0100
    @@ -1,11 +1,15 @@
     # Copyright 1999-2021 Gentoo Authors
     # Distributed under the terms of the GNU General Public License v2
    
    +# ::slyfox note: forked ebuild because ::gento does not support glibc-2.34:
    +# https://bugs.gentoo.org/803485
    +# We pull in dev-libs/gnulib and update bundled files.
    +
     # Note: if your package uses the texi2dvi utility, it must depend on the
     # virtual/texi2dvi package to pull in all the right deps.  The tool is not
     # usable out-of-the-box because it requires the large tex packages.
    
    -EAPI=7
    +EAPI=8
    
     inherit flag-o-matic toolchain-funcs
    
    @@ -15,7 +19,7 @@
    
     LICENSE="GPL-3"
     SLOT="0"
    -KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
    +#KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
     IUSE="nls +standalone static"
    
     RDEPEND="
    @@ -30,11 +34,17 @@
            )
            nls? ( virtual/libintl )"
     DEPEND="${RDEPEND}"
    -BDEPEND="nls? ( >=sys-devel/gettext-0.19.6 )"
    +BDEPEND="
    +       >=dev-libs/gnulib-9999-r1
    +       nls? ( >=sys-devel/gettext-0.19.6 )
    +"
    
     src_prepare() {
            default
    
    +       # https://bugs.gentoo.org/803485
    +       gnulib-tool --update || die
    +
            if use prefix ; then
                sed -i -e '1c\#!/usr/bin/env sh' util/texi2dvi util/texi2pdf || die
                touch doc/{texi2dvi,texi2pdf,pdftexi2dvi}.1
