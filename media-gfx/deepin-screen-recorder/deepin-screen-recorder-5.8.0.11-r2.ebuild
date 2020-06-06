# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="Deepin Screencasting and Screenshot Application"
HOMEPAGE="https://github.com/linuxdeepin/deepin-screen-recorder/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+gif +mp4"

REQUIRED_USE="|| ( gif mp4 )"

RDEPEND="dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
		dev-qt/qtx11extras:5
		x11-libs/libXtst
		gif? ( media-gfx/byzanz )
		mp4? ( media-video/ffmpeg[x264] )
		!media-gfx/deepin-screenshot
		"

DEPEND="${RDEPEND}
		x11-libs/xcb-util
		x11-libs/libxcb
		>=dde-base/dtkwidget-5.1.2:=
		dde-base/dtkgui:=
		"

PATCHES=(
		"${FILESDIR}/${P}-build-fix.patch"
)

src_prepare() {
	default
	QT_SELECT=qt5 eqmake5 screen_shot_recorder.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
