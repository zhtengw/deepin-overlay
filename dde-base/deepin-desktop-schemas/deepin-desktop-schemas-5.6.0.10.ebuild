# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

EGO_PN="deepin-desktop-schemas"
inherit gnome2-utils golang-vcs-snapshot

DESCRIPTION="GSettings deepin desktop-wide schemas"
HOMEPAGE="https://github.com/linuxdeepin/deepin-desktop-schemas"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3+"
SLOT="0"
IUSE=""

DEPEND="dev-libs/glib:2
		>=dde-base/deepin-desktop-base-2020.04.12
		>=dev-go/deepin-go-lib-5.4.5"


src_prepare() {
	export GOPATH="$(get_golibdir_gopath)"

	default_src_prepare
}

src_compile() {
	cd ${S}/src/${EGO_PN}
	emake ARCH=x86
}

src_install() {
	cd ${S}/src/${EGO_PN}/result/
	#emake DESTDIR=${D} install

	insinto /usr/share/${PN}
	doins *-override

	insinto /usr/share/glib-2.0/schemas
	doins *.xml
}

pkg_preinst() { gnome2_schemas_savelist;}
pkg_postinst() { gnome2_schemas_update; }
pkg_postrm() { gnome2_schemas_update; }
