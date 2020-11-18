# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="PDF Document Viewer for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-reader"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtxml:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsql:5
		app-text/poppler[qt5]
		kde-frameworks/karchive
		x11-libs/libX11
		media-libs/tiff
		media-libs/openjpeg:2
		media-libs/libjpeg-turbo
		app-text/djvu
		app-text/libspectre
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dtkgui-5.1.2:=
		dev-qt/linguist-tools
		virtual/pkgconfig
		"

PATCHES=(
	"$FILESDIR/5.8.0.5-build-with-qt5.15.patch"
)

src_prepare() {

	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib|/usr/${LIBDIR}|g" \
		3rdparty/deepin-pdfium/src/src.pro \
		src/src.pro || die
	sed -i "s/LIBS\ +=\ /LIBS\ +=\ -ljpeg\ /g" 3rdparty/deepin-pdfium/src/3rdparty/pdfium/pdfium.pri || die
	QT_SELECT=qt5 eqmake5 PREFIX=/usr DEFINES+="VERSION=${PV}"
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
