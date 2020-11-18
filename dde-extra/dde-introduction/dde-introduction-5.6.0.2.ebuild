# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Deepin Initialization Setup Tool"
HOMEPAGE="https://github.com/linuxdeepin/dde-introduction"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtdbus:5
		dev-qt/qtmultimedia:5[widgets]
		>=dde-base/dde-meta-20
		media-video/deepin-movie-reborn
		"

DEPEND="${RDEPEND}
		dde-base/dde-qt-dbus-factory
		>=dde-base/dtkwidget-5.1.2:=
		"

src_prepare() {
	eapply_user

	sed -i "/<QPainter>/a\#include <QPainterPath>" \
		src/widgets/navigationbutton.h \
		src/dvideowidget.h \
		src/widgets/coverphoto.h || die
	sed -i "/<QDebug>/a\#include <QPainterPath>" \
		src/widgets/closebutton.cpp || die

	sed -i "s/\ qm_files//" introduction.pro || die
	QT_SELECT=qt5 eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
