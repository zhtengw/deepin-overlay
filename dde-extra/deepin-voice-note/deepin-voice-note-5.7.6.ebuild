# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="A lightweight memo tool to make text notes and voice recordings"
HOMEPAGE="https://github.com/linuxdeepin/deepin_voice_note"

MY_PN=${PN//-/_}
MY_P=${MY_PN}-${PV}
SRC_URI="https://github.com/linuxdeepin/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${MY_P}
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5
	dev-qt/qtdbus:5
	x11-libs/startup-notification
	"

DEPEND="${RDEPEND}
		media-libs/fontconfig
		media-libs/freetype
		virtual/ffmpeg
		>=dde-base/dde-qt-dbus-factory-5.0.16
		>=dde-base/dtkwidget-5.1.2:=
		"

src_prepare() {
	eapply_user
	sed -i "/<QList>/a\#include\ <QObject>" src/Controllers/foldercontroller.h || die
	sed -i "/<QFrame>/a\#include\ <QMouseEvent>" src/views/leftfolderlist.cpp || die
	QT_SELECT=qt5 eqmake5 DEFINES+="VERSION=${PV}" ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
