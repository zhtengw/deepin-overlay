# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin - Widget modules"
HOMEPAGE="https://github.com/linuxdeepin/dtkwidget"

if [[ "${PV}" == *9999* ]] ; then
     inherit git-r3
     EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
     SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi
LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5[widgets]
		 dev-qt/qtdbus:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtconcurrent:5
		 dev-qt/qtx11extras:5
		 >=dev-qt/qtcore-5.5:5
		 x11-libs/libXrender
		 x11-libs/libxcb
		 x11-libs/libXext
		 x11-libs/xcb-util
		 x11-libs/startup-notification
		 x11-libs/gsettings-qt
		 x11-proto/xextproto
		 sys-libs/mtdev
		 media-libs/freetype
		 media-libs/fontconfig
		 media-libs/mesa
		 virtual/libudev
		 !<=dde-base/deepin-tool-kit-0.3.3
	     "
DEPEND="${RDEPEND}
		dev-libs/glib:2
		dde-base/dtkcore
		dev-qt/linguist-tools:5
	    "

src_prepare() {
	local mylrelease=$(qt5_get_bindir)/lrelease
	sed -i -e "s:lrelease:${mylrelease}:" tool/translate_generation.sh || die
	eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir)
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

