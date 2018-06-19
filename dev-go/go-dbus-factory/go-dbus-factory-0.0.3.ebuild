# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Go bindings to generate D-Bus services"
HOMEPAGE="https://github.com/linuxdeepin/go-dbus-factory"
SRC_URI="https://github.com/linuxdeepin/go-dbus-factory/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-go/deepin-go-lib"

src_prepare() {
	mkdir -p ${S}/build/src/github.com/linuxdeepin
	ln -s ${S} ${S}/build/src/github.com/linuxdeepin/go-dbus-factory

	export GOPATH="/usr/share/gocode:${S}/build"
}

src_compile() {
	emake bin
	${S}/gen.sh
}

src_install() {
	insinto /usr/share/gocode/src/github.com/linuxdeepin/go-dbus-factory
	doins -r com.* org.* net.* object_manager 
}

