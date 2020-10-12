# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/fsnotify/fsnotify
EGO_VENDOR=( "golang.org/x/sys a893ed343c856cd934ea1497e570b5dbc52d681e github.com/golang/sys")
inherit golang-vcs-snapshot golang-build

KEYWORDS="~amd64"
EGIT_COMMIT=45d7d09e39ef4ac08d493309fa031790c15bfe8a
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz 
${EGO_VENDOR_URI}"

DESCRIPTION="Filesystem notify in Go"
HOMEPAGE="https://github.com/fsnotify/fsnotify"
LICENSE="BSD"
SLOT="0/${PVR}"
RDEPEND=""
DEPEND="${RDEPEND}"
