# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Deepin Multimedia Softwares (meta package)"
HOMEPAGE="https://www.deepin.org"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-sound/deepin-music
		media-video/deepin-movie-reborn
		|| ( >=media-gfx/deepin-screen-recorder-5.8.0
		( media-gfx/deepin-screenshot
		<=media-gfx/deepin-screen-recorder-5.0.0 )
		)
		media-sound/deepin-voice-recorder
		media-gfx/deepin-image-viewer
		media-gfx/deepin-draw
		media-gfx/deepin-album
		"
