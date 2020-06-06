# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Deepin desktop environment - Launcher module"
HOMEPAGE="https://github.com/linuxdeepin/dde-launcher"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >=dde-base/deepin-menu-5.0.1
		 dde-base/dde-daemon
		 x11-misc/xdg-user-dirs
		 >=dde-base/deepin-desktop-schemas-5.4.0
		 x11-libs/gsettings-qt
	     "
DEPEND="${RDEPEND}
		x11-libs/xcb-util-wm
		x11-libs/libxcb
		>=dde-base/dtkwidget-5.1.2:=
		dde-base/dde-qt-dbus-factory:=
		"

PATCHES=(
	"$FILESDIR/5.2.0.0-build-with-qt5.15.patch"
)

src_configure() {
	local mycmakeargs=(
		-DWITHOUT_UNINSTALL_APP=1
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

