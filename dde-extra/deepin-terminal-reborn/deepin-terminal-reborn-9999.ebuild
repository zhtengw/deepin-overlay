# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Deepin Terminal"
HOMEPAGE="https://github.com/linuxdeepin/deepin-terminal-reborn"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	>=dde-base/dtkcore-5.1.2
	dde-base/dtkgui
	"
DEPEND="${RDEPEND}
	dev-util/lxqt-build-tools
	>=dde-base/dtkwidget-5.1.2:=
	virtual/pkgconfig
	"

src_prepare() {
	sed -i "/include/a\#include\ <cwctype>" \
		terminalwidget/lib/konsole_wcwidth.h || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
	)
	cmake-utils_src_configure
}

