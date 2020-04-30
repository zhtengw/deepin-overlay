# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="A Tool to create a bootable usb stick quick and easy"
HOMEPAGE="https://github.com/linuxdeepin/deepin-boot-maker"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtconcurrent:5
		dev-qt/qtgui:5 
	    dev-qt/qtwidgets:5
	   	dev-qt/qtnetwork:5
		dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtsvg:5
		dev-qt/qtdbus:5
		dev-qt/qtx11extras:5
		x11-libs/libxcb
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/xcb-util
		x11-libs/startup-notification
		app-arch/p7zip
		sys-fs/mtools
		sys-boot/syslinux
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.5:2=
		virtual/pkgconfig
		dev-lang/python
	    "

src_prepare() {
	eapply_user
	sed -i "s|dtkcore|dtkcore2|g" \
		src/service/vendor.pri \
		src/libdbm/vendor.pri \
		src/app/vendor.pri || die
	sed -i "s|dtkwidget|dtkwidget2|g" \
		src/app/vendor.pri || die
	sed -i "s|DTK_|DTK2_|g" \
		src/service/vendor.pri || die

	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" src/vendor/src/libxsys/libxsys.pro src/service/service.pro || die
	sed -i "s|/usr/lib|/usr/${LIBDIR}|g" src/libdbm/libdbm.pro src/service/data/com.deepin.bootmaker.service || die
	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
