# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Deepin Desktop Enviroment (meta package)"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dde-base/dde-control-center-4.0.0
		<dde-base/startdde-3.0.14
		dde-base/dde-file-manager
		<dde-base/dde-desktop-4.0.0
		dde-base/dde-launcher
		dde-base/dde-dock
		dde-base/deepin-desktop-base
		<dde-base/dde-session-ui-3.0.23
		dde-base/deepin-notifications
		"

