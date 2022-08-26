# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils git-r3

DESCRIPTION="Editor of tesseract-ocr box files"
HOMEPAGE="http://zdenop.github.com/qt-box-editor/"
#SRC_URI="https://github.com/zdenop/qt-box-editor/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/zdenop/qt-box-editor"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

# No tesseract-5 support upstream yet:
#   https://github.com/zdenop/qt-box-editor/issues/86
RDEPEND="
	<app-text/tesseract-5:=
	dev-qt/qtwidgets:5=
	dev-qt/qtcore:5=
	dev-qt/qtgui:5=
	dev-qt/qtnetwork:5=
	dev-qt/qtsvg:5=
	media-libs/leptonica:=
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	INSTALL_ROOT=${D}/usr default
}
