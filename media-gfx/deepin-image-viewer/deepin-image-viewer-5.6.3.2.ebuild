# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Deepin Image Viewer"
HOMEPAGE="https://github.com/linuxdeepin/deepin-image-viewer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+jpeg +png +tiff raw mng jpeg2k"

RDEPEND="dev-qt/qtsvg:5
		dev-qt/qtgui:5
		dev-qt/qtconcurrent:5
		dev-qt/qtdbus:5
		dev-qt/qtprintsupport:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtopengl:5
		dev-qt/qtimageformats:5
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libraw
		media-libs/libexif
		media-libs/libglvnd
		media-libs/freeimage[jpeg?,png?,tiff?,raw?,mng?,jpeg2k?]
		sys-libs/mtdev
		virtual/libudev
		x11-base/xorg-proto
		x11-libs/libXrender
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		dev-qt/gio-qt
		dde-base/udisks2-qt5
	    "

PATCHES=(
	"$FILESDIR"/5.6.3.2-build-with-qt5.15.patch
)

src_prepare() {

	# the same manual_icon and app_icon install in the same path
	sed -i 's|app_icon\ ||g' viewer/viewer.pro || die
	export QT_SELECT=qt5
	eqmake5 DEFINES+="VERSION=${PV}"

	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
