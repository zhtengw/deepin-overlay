# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit cmake-utils versionator

MY_VER="$(get_version_component_range 1-3)+git$(get_version_component_range 4)"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.orig.tar.gz"

DESCRIPTION="Sound recorder and voice recognition"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-misc/xsel
		x11-libs/gksu"
DEPEND="${RDEPEND}
		x11-libs/libwnck:3
		sys-apps/dbus
		dev-libs/dbus-glib
		x11-libs/libXtst
		media-libs/alsa-lib
		media-sound/pulseaudio
		x11-libs/libXmu
		dev-db/sqlite"
S="${WORKDIR}"

src_install() {
	cmake-utils_src_install 
	
	insinto "/usr/share/dbus-1/services"
	doins ${S}/dbus-config/com.deepin.speech.service
	
	if use x86 ; then
		dolib ${S}/ThirdParty/lib/i686/*
	elif use amd64 ; then
		dolib ${S}/ThirdParty/lib/x86_64/*
	fi
	
	insinto "/usr/share/applications"
	doins ${S}/debian/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}