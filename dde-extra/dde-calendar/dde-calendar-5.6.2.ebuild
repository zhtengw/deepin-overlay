# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

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
	sed -i "/<DPalette>/a\#include\ <QMouseEvent>" \
		src/yearwindow.cpp \
		src/schcedulesearchview.cpp || die
	sed -i "/<QMessageBox>/a\#include\ <QWheelEvent>" \
		src/yearwindow.cpp \
		src/monthwindow.cpp \
		src/daymonthview.cpp || die
	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr  DEFINES+="VERSION=${PV}" calendar.pro
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
