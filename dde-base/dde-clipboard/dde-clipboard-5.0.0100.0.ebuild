# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Deepin Clipboard"
HOMEPAGE="https://github.com/linuxdeepin/dde-clipboard"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		dde-base/dde-network-utils
		sys-libs/mtdev
		x11-libs/libXrandr
		media-libs/fontconfig
		media-libs/freetype
		dev-qt/gio-qt
		media-libs/libglvnd
		x11-libs/xcb-util-wm
		kde-frameworks/networkmanager-qt
		x11-libs/libX11
		>=dde-base/dde-daemon-5.9.0
		>=dde-base/dde-api-5.1.1
		dde-base/deepin-desktop-base
		"

DEPEND="${RDEPEND}
		dde-base/dde-qt-dbus-factory
		x11-libs/gsettings-qt
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dtkgui-5.1.2:=
		virtual/pkgconfig
		"

src_prepare() {

	QT_SELECT=qt5 eqmake5 PREFIX=/usr DEFINES+="VERSION=${PV}"
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
