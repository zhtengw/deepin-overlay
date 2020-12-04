# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

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
		net-libs/zeromq
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
	sed -i "/<QDebug>/a\#include\ <QContextMenuEvent>\n\#include\ <QKeyEvent>" \
		deepin-devicemanager/src/Widget/TextBrowser.cpp || die
	sed -i "/<QDebug>/a\#include\ <QPainterPath>" \
		deepin-devicemanager/src/Widget/logtreeview.cpp || die
	sed -i "/<QList>/a\#include\ <QMap>" \
		deepin-devicemanager/src/DeviceManager/DeviceManager.h || die
	sed -i "/<QList>/a\#include\ <QFile>" \
		deepin-devicemanager/src/Widget/logtreeview.cpp || die
	sed -i "/<QList>/a\#include\ <QIODevice>" \
		deepin-devicemanager/3rdparty/docx/opc/packagereader.h || die
	sed -i "/<QPainter>/a\#include\ <QPainterPath>" \
		deepin-devicemanager/src/Page/PageInfo.cpp \
		deepin-devicemanager/src/Page/PageDetail.cpp \
		deepin-devicemanager/src/Widget/CmdButtonWidget.cpp \
		deepin-devicemanager/src/Widget/DetailViewDelegate.cpp \
		deepin-devicemanager/src/Widget/RichTextDelegate.cpp \
		deepin-devicemanager/src/Widget/DeviceListView.cpp \
		deepin-devicemanager/src/Widget/DetailTreeView.cpp \
		deepin-devicemanager/src/Widget/TableWidget.cpp \
		deepin-devicemanager/src/Widget/logviewheaderview.cpp \
		deepin-devicemanager/src/Widget/logviewitemdelegate.cpp || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

