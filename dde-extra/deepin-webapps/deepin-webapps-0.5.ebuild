# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}.orig.tar.gz"

DESCRIPTION="Web Apps apply by Deepin"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( www-client/google-chrome www-client/google-chrome-beta www-client/google-chrome-unstable )
		x11-misc/xdg-utils"
DEPEND=""
S="${WORKDIR}"

src_install() {
	insinto "/usr/share/applications"
	doins ${S}/desktops/*.desktop
	
	insinto "/usr/share/${PN}"
	doins  ${S}/html/*.html
	
	doicon -s 48 ${S}/icons/*.png

}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}