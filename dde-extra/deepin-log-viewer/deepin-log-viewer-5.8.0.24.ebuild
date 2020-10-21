# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Deepin Log Viewer"
HOMEPAGE="https://github.com/linuxdeepin/deepin-log-viewer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="elogind systemd"
REQUIRED_USE="^^ ( systemd elogind )"

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtx11extras:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		dev-qt/linguist-tools
		virtual/pkgconfig
		"

PATCHES=(                                   
	"${FILESDIR}"/5.6.6-u_errorName.patch
)

src_prepare() {

	sed -i "/<QList>/a\#include\ <QIODevice>" \
		3rdparty/docx/opc/packagereader.h || die
	sed -i "/<QPainter>/a\#include\ <QPainterPath>" \
		application/logperiodbutton.cpp || die
	sed -i "/<QDebug>/a\#include\ <QPainterPath>" \
		application/displaycontent.cpp \
		application/logtreeview.cpp \
		application/logviewheaderview.cpp \
		application/logviewitemdelegate.cpp \
		application/logdetailinfowidget.cpp \
		application/filtercontent.cpp || die

	if use elogind && ! use systemd ; then
		sed -i "s/-lsystemd/-lelogind/" \
			application/CMakeLists.txt || die
		sed -i "s|systemd/|elogind/systemd/|" \
			application/journalwork.h || die
	fi
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}
