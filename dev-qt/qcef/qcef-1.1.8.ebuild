# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

#inherit cmake-utils git-r3
inherit cmake-utils

DESCRIPTION="Qt5 binding of Chromium Embedded Framework"
HOMEPAGE="https://github.com/linuxdeepin/qcef"

SRC_URI="https://community-packages.deepin.com/deepin/pool/main/q/${PN}/${PN}_${PV}.orig.tar.xz -> ${P}.tar.xz
		https://github.com/linuxdeepin/cef-binary/archive/master.zip -> cef-bin.zip"

#EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
#EGIT_COMMIT="${PV}"
#EGIT_COMMIT="016fa9c"
#EGIT_SUBMODULES=( cef )

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtwebchannel:5
		dev-qt/qtx11extras:5
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXtst
		x11-libs/libXScrnSaver
		x11-libs/gtk+:2
		media-libs/fontconfig
		media-libs/harfbuzz
		media-libs/alsa-lib
		media-libs/mesa
		dev-libs/glib
		dev-libs/nspr
		dev-libs/nss
		media-sound/pulseaudio
		net-print/cups
		sys-devel/flex
		gnome-base/gconf
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"
PATCHES=( 
	"${FILESDIR}"/1.1.7-fix-qt5.14.patch 
)

src_unpack() {
	default
	mv ${WORKDIR}/cef-binary-master/* ${S}/cef/
}
src_configure() {
	local mycmakeargs=(
		-DQCEF_INSTALL_PATH=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}
