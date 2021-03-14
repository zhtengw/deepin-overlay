# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Install and Uninstall Font File for Users"
HOMEPAGE="https://github.com/linuxdeepin/deepin-font-installer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 media-libs/freetype:2
		 media-libs/fontconfig
		 dde-base/dde-file-manager:=
	     "
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.1:2=
	    "

src_prepare() {
	sed -i "s|dtkwidget|dtkwidget2|g" \
		libdeepin-font-installer/libdeepin-font-installer.pro \
		deepin-font-installer/deepin-font-installer.pro \
		deepin-font-preview-plugin/deepin-font-preview-plugin.pro || die
	export QT_SELECT=qt5 
	eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

