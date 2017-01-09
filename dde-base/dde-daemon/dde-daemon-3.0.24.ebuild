# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5


DESCRIPTION="Daemon handling the DDE session settings"
HOMEPAGE="https://github.com/linuxdeepin/dde-daemon"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wacom"

RDEPEND="x11-wm/deepin-metacity
		sys-power/upower
		x11-libs/libxkbfile
		app-text/iso-codes
		sys-apps/accountsservice
		sys-power/acpid
		sys-fs/udisks:2
		gnome-extra/polkit-gnome
		dde-base/deepin-desktop-schemas
		net-misc/networkmanager
		net-wireless/bluez
		gnome-base/gvfs
		>sys-power/upower-0.99
		
		wacom? ( x11-drivers/xf86-input-wacom )
	      "
DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
	      dev-go/deepin-go-lib
	      dev-go/dbus-factory
	      >=dde-base/dde-api-2.92.2
	      dev-db/sqlite:3
	      "
	      
src_prepare() {
		export GOPATH="/usr/share/gocode"
		
#		mkdir -p ${S}/src/code.google.com/p/graphics-go/
#		mkdir -p ${S}/src/code.google.com/p/jamslam-freetype-go/
		
#		cp -r ${WORKDIR}/graphics ${S}/src/code.google.com/p/graphics-go/
#		cp -r ${WORKDIR}/freetype ${S}/src/code.google.com/p/jamslam-freetype-go/
		
}
