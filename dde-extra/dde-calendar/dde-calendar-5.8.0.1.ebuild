# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Calendar for Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/dde-calendar"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
		dev-qt/qtdbus:5"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" \
		schedule-plugin/CMakeLists.txt || die

	sed -i "/\#include\ \"\.\./a\#include\ <QMouseEvent>" \
		schedule-plugin/src/widget/modifyscheduleitem.cpp \
		schedule-plugin/src/widget/scheduleitemwidget.cpp || die
	sed -i "/\#include\ <DMenu>/a\#include\ <QMouseEvent>" \
		src/view/draginfographicsview.cpp || die
	sed -i "/\#include\ <QEvent>/a\#include\ <QWheelEvent>" \
		src/widget/weekWidget/weekheadview.cpp \
		src/widget/dayWidget/daymonthview.cpp || die
	sed -i "/\#include\ <D/a\#include\ <QPainterPath>" \
		schedule-plugin/src/widget/itemwidget.cpp \
		src/customWidget/customframe.cpp || die
	sed -i "/\#include\ <QPainter>/a\#include\ <QPainterPath>\n\#include\ <QMouseEvent>" \
		src/widget/dayWidget/daymonthview.cpp \
		src/widget/schedulesearchview.cpp || die
	sed -i "/\#include\ <QPainter>/a\#include\ <QPainterPath>" \
		src/widget/yearWidget/yearview.cpp \
		src/widget/weekWidget/weekheadview.cpp || die
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(             
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

