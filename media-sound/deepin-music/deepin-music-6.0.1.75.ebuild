# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake

DESCRIPTION="Deepin Music Player"
HOMEPAGE="https://github.com/linuxdeepin/deepin-music"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+mp3 +flac +ogg +aac"

RDEPEND="dev-qt/qtmultimedia:5[gstreamer]
	dev-libs/icu
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	>dde-base/deepin-menu-2.90.1
	sys-devel/bison
	media-libs/libcue
	media-video/ffmpeg
	media-video/vlc
	>=media-libs/taglib-1.10
	media-plugins/gst-plugins-meta:1.0[mp3=,flac=,ogg=,aac=]
	"
DEPEND="${RDEPEND}
	>=dde-base/dtkwidget-5.1.2:=
	"

PATCHES=(
	"$FILESDIR"/6.0.1.75-build-with-qt5.15.patch
)

src_prepare() {
#	LIBDIR=$(qt5_get_libdir)
#	sed -i "s|\$\${PREFIX}/lib|${LIBDIR}|g" music/plugin/netease-meta-search/netease-meta-search.pro  || die
#	sed -i "/<QDebug>/a\#include\ <QFile>" music/music-player/core/player.cpp || die

	cmake_src_prepare
}

src_install() {
	cmake_src_install
}
