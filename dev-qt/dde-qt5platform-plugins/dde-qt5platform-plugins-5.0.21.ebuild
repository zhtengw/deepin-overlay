# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
inherit qmake-utils

DESCRIPTION="XCB Qt5 platform plugin for DDE"
HOMEPAGE="https://github.com/linuxdeepin/qt5platform-plugins"
MY_PN=${PN#*-}
MY_P=${MY_PN}-${PV}

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${MY_PN}.git"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/linuxdeepin/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	dev-qt/qtx11extras:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtopengl
	dev-qt/qtxcb-private-headers:5=
	dev-libs/dde-wayland
	kde-frameworks/kwayland
	x11-libs/libxcb[xkb]
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-image
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	!<=dde-base/dde-qt5integration-0.2.7
	"
DEPEND="${RDEPEND}
		"

src_prepare() {
	sed -i 's/active\ =\ VtableHook::overrideVfptrFun.*/active\ =\ 1;/' xcb/dhighdpi.cpp || die
	QT_SELECT=qt5 eqmake5 ${MY_PN}.pro
	default
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
