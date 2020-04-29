# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin Device Manager"
HOMEPAGE="https://github.com/linuxdeepin/deepin-devicemanager"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtsvg:5
		dev-qt/qtxml:5
		net-print/cups
		sys-apps/smartmontools
		sys-apps/dmidecode
		sys-apps/hwinfo
		sys-power/upower
		sys-apps/lshw
		sys-apps/util-linux
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dtkgui-5.1.2:=
		>=dde-base/dde-qt-dbus-factory-5.0.16
		virtual/pkgconfig
		"

src_prepare() {
	sed -i "/<QList>/a\#include\ <QFile>" \
		src/deviceinfowidgetbase.h || die
	sed -i "/<QList>/a\#include\ <QIODevice>" \
		thirdlib/docx/opc/packagereader.h || die
	sed -i "/\"DSpinner\"/a\#include\ <QKeyEvent>" \
		src/mainwindow.cpp || die
	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr  DEFINES+="VERSION=${PV}"
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
