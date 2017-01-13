# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-tool-kit"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5
		 dev-qt/qtx11extras:5
		 >=dev-qt/qtcore-5.5:5
	     "
DEPEND="${RDEPEND}
	     "

src_prepare() {
		eqmake5	
}

src_install() {
		emake INSTALL_ROOT=${D} install
		rm -r ${D}/usr/share
}

