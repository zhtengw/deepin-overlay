# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="pkg.deepin.io/lib/"

inherit golang-vcs-snapshot

DESCRIPTION="Deepin GoLang Library"
HOMEPAGE="https://github.com/linuxdeepin/go-lib"
MY_PN="go-dlib"
SRC_URI="https://community-packages.deepin.com/deepin/pool/main/g/${MY_PN}/${MY_PN}_${PV}.orig.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"



src_install() {
	insinto $(get_golibdir_gopath)
	doins -r src
}
