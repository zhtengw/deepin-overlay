# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/linuxdeepin/go-x11-client"

inherit golang-vcs-snapshot

DESCRIPTION="Deepin GoLang X11 client Library"
HOMEPAGE="https://github.com/linuxdeepin/go-x11-client"
SRC_URI="https://community-packages.deepin.com/deepin/pool/main/g/golang-github-linuxdeepin-${PN}/golang-github-linuxdeepin-${PN}_${PV}.orig.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

src_install() {
	rm -r ${S}/src/${EGO_PN}/debian
	insinto $(get_golibdir_gopath)
	doins -r src
}
