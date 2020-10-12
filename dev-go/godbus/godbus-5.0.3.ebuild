# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/godbus/dbus

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT=3ba01c041d7a898d8998fcac0ebe2d61acd0a19f
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go client bindings for the D-Bus message bus system"
HOMEPAGE="https://github.com/godbus/dbus"
LICENSE="BSD"
SLOT="0/${PVR}"
RDEPEND=""
DEPEND="${RDEPEND}"
