# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Deepin Painting Tool"
HOMEPAGE="https://github.com/linuxdeepin/deepin-draw"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+jpeg +png +tiff raw mng jpeg2k"

RDEPEND="dev-qt/qtsvg:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		dev-qt/qtopengl:5
		media-libs/libraw
		media-libs/libexif
		media-libs/freeimage[jpeg?,png?,tiff?,raw?,mng?,jpeg2k?]
		dde-extra/deepin-picker
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
	    "

#PATCHES=("$FILESDIR/5.8.0.66-dwidget.patch")

src_prepare() {
#	eapply_user
#	sed -i '/<DGraphicsView>/a\#include\ <QFile>' \
#		frame/cgraphicsview.h || die
#	sed -i '/<QDebug>/a\#include\ <QMouseEvent>' \
#		widgets/ciconbutton.cpp || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
