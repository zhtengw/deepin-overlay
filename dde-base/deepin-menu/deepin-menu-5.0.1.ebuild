# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7


inherit qmake-utils

DESCRIPTION="Deepin menu service for building beautiful menus"
HOMEPAGE="https://github.com/linuxdeepin/deepin-menu"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}
		x11-libs/libX11
		x11-libs/libxcb
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dde-qt-dbus-factory-5.0.16
		>=dde-base/dde-qt5integration-5.1.0
		>=dde-base/dde-api-5.1.1
		dev-qt/qtx11extras:5
		dev-qt/qtdeclarative:5
	    "
src_prepare() {
	QT_SELECT=qt5 eqmake5
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
