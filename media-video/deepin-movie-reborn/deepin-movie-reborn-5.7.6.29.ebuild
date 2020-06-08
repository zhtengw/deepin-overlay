# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils xdg-utils
DESCRIPTION="Deepin Movie Player"
HOMEPAGE="https://github.com/linuxdeepin/deepin-movie-reborn"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdbus:5
		dev-qt/qtwidgets:5
		dev-qt/linguist-tools:5
		dev-qt/qtsvg:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
		dev-libs/openssl
		media-video/mpv[libmpv,dvd]
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-wm
		x11-base/xcb-proto
		x11-base/xorg-proto
		media-video/ffmpegthumbnailer
		x11-libs/libXtst
		media-sound/pulseaudio
		media-video/ffmpeg
		media-libs/libdvdnav
		"
RDEPEND="${DEPEND}
		>=dde-base/dtkcore-5.1.2
		>=dde-base/dtkwidget-5.1.2:=
		"

PATCHES=(
	"$FILESDIR"/5.7.6.29-build-with-qt5.15.patch
)

src_prepare() {
    LIBDIR=$(get_libdir)
    sed -i "s|lib/|${LIBDIR}/|g" src/CMakeLists.txt || die
    cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
    xdg_icon_cache_update
}
