# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="DDE wayland client and server with DDE custom protocol"
HOMEPAGE="https://github.com/linuxdeepin/dde-wayland"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
	EGIT_BRANCH="develop2.0"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtdeclarative:5
		dev-qt/qtwayland:5
		dev-libs/wayland
		"
DEPEND="${RDEPEND}
		"

src_prepare() {

	LIBDIR=$(get_libdir)
	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr VERSION=${PV} DEFINES+="VERSION=${PV}" LIB_INSTALL_DIR=/usr/$(get_libdir) ${PN}.pro || die
	default_src_prepare
}

src_install() {

		emake INSTALL_ROOT=${D} install

}

