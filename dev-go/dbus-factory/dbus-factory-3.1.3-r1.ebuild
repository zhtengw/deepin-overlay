# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Dbus library binding for golang"
HOMEPAGE="https://github.com/linuxdeepin/dbus-factory"
SRC_URI="https://github.com/linuxdeepin/dbus-factory/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+go-1.8"

DEPEND="sys-devel/gcc[go]
	go-1.8? ( =dev-lang/go-1.8* )
	!go-1.8? ( =dev-lang/go-1.7* )
	dev-go/go-dbus-generator"

src_prepare() {
	use go-1.8 && sed -i 's| tp:type="String_Variant_Map"||g' xml/nm-device-gre.xml
	export GOPATH="/usr/share/gocode"
}
