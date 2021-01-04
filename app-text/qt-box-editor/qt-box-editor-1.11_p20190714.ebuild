# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils

COMMIT=cba2929dabc6c715acd1a282ba161fee914c87f6

DESCRIPTION="Editor of tesseract-ocr box files"
HOMEPAGE="http://zdenop.github.com/qt-box-editor/"
SRC_URI="https://github.com/zdenop/qt-box-editor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-text/tesseract:=
	dev-qt/qtwidgets:5=
	dev-qt/qtcore:5=
	dev-qt/qtgui:5=
	dev-qt/qtnetwork:5=
	media-libs/leptonica:=
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/qt-box-editor-${COMMIT}

src_configure() {
	eqmake5
}

src_install() {
	INSTALL_ROOT=${D}/usr default
}
