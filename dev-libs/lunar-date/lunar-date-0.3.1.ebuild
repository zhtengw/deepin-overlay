# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils 

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"

DESCRIPTION="Chinese Lunar library fork by LinuxDeepin project"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/gobject-introspection
		dev-libs/glib:2
		dev-libs/dtk-widget"
DEPEND="${RDEPEND}
		dev-util/gtk-doc"
S="${WORKDIR}"

src_prepare() {
	sed -i 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' ./configure.ac
	./autogen.sh --prefix=/usr
}
