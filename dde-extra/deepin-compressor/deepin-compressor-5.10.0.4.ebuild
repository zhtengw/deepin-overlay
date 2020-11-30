# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Archive Manager for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-compressor"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtxml:5
		dev-qt/qtconcurrent:5
		dev-qt/qtx11extras:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		kde-frameworks/kcodecs
		app-text/poppler[cxx]
		app-crypt/libsecret
		x11-libs/gsettings-qt
		dev-libs/disomaster
		app-arch/libarchive
		dev-libs/libzip
		sys-libs/zlib[minizip]
		kde-frameworks/karchive
		"

DEPEND="${RDEPEND}
		dde-base/udisks2-qt5
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dtkgui-5.1.2:=
		dev-qt/linguist-tools
		virtual/pkgconfig
		"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "/<QDebug>/a\#include <QPainterPath>" \
		deepin-compressor/source/src/logviewheaderview.cpp \
		deepin-compressor/source/src/openwithdialog/openwithdialog.cpp \
		deepin-compressor/source/src/fileViewer.cpp || die
	sed -i "s|/lib|/${LIBDIR}|g" CMakeLists.txt || die
	sed -i "s|DESTINATION lib|DESTINATION ${LIBDIR}|g" CMakeLists.txt || die
	sed -i "s|qt5_create_translation|\#qt5_create_translation|g" deepin-compressor/CMakeLists.txt || die

	cmake-utils_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}
