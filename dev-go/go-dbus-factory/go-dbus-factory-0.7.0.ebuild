# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/linuxdeepin/go-dbus-factory"

inherit golang-vcs-snapshot

DESCRIPTION="Go bindings to generate D-Bus services"
HOMEPAGE="https://github.com/linuxdeepin/go-dbus-factory"
SRC_URI="https://github.com/linuxdeepin/go-dbus-factory/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-go/deepin-go-lib"


src_compile() {
	export GOPATH=$(get_golibdir_gopath)
	cd ${S}/src/${EGO_PN}
	emake bin
	${S}/src/${EGO_PN}/gen.sh
}

src_install() {
	insinto $(get_golibdir_gopath)/src/${EGO_PN}
	cd ${S}/src/${EGO_PN}
	doins -r object_manager net.* org.* com.*
}

