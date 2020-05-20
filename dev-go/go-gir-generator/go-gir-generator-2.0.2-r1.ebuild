# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="pkg.deepin.io/gir"

inherit golang-base

DESCRIPTION="Generate static golang bindings for GObject"
HOMEPAGE="https://github.com/linuxdeepin/go-gir-generator"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="dev-libs/gobject-introspection
	dev-libs/libgudev[introspection]"

src_prepare() {
	# fix with >=dev-libs/glib-2.63
	sed -i "s/\"connect\"/\"connect\"\,\n\"source_new\"/" lib.in/gio-2.0/config.json || die
	export -n GOCACHE XDG_CACHE_HOME
	default_src_prepare
}

src_install() {
	dobin out/gir-generator
	insinto $(get_golibdir_gopath)
	doins -r out/src
}
