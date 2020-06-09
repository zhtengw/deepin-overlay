# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin - Widget modules"
HOMEPAGE="https://github.com/linuxdeepin/dtkwidget"

if [[ "${PV}" == *9999* ]] ; then
     inherit git-r3
     EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
     SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	 KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="2/${PV}"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5[widgets]
		 dev-qt/qtdbus:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtconcurrent:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtsvg:5
		 >=dev-qt/qtcore-5.5:5
		 x11-libs/libXrender
		 x11-libs/libxcb
		 x11-libs/libXext
		 x11-libs/xcb-util
		 x11-libs/startup-notification
		 x11-libs/gsettings-qt
		 x11-base/xorg-proto
		 sys-libs/mtdev
		 gnome-base/librsvg:2
		 media-libs/freetype
		 media-libs/fontconfig
		 media-libs/mesa
		 virtual/libudev
		 !<=dde-base/deepin-tool-kit-0.3.3
		"
DEPEND="${RDEPEND}
		dev-libs/glib:2
		dde-base/dtkcore:=
		>=dde-base/dde-qt-dbus-factory-5.0.0
		dev-qt/linguist-tools:5
		"

PATCHES=(
	"$FILESDIR"/2.1.1-build-with-qt5.15.patch
)

src_prepare() {
	default_src_prepare

	# build with dtk version 2
	sed -i "s/\(TARGET\ =\ dtkwidget\)/\12/" src/src.pro || die
	sed -i "s/DWIDGET_TRANSLATIONS_DIR/DWIDGET2_TRANSLATIONS_DIR/g" \
		src/widgets/dapplication.cpp || die
	sed -i "s/DtkWidget/DtkWidget2/g" \
		src/src.pro || die
	sed -i "s/dtkwidget_config/dtkwidget2_config/g" \
		src/src.pro \
		src/dtkwidget_global.h || die
	sed -i "s/-ldtkwidget/-ldtkwidget2/g" \
		examples/dwidget-examples/collections/collections.pro || die
	sed -i "s/QT\ +=\ dtkcore/QT\ +=\ dtkcore2/g" \
		src/src.pro \
		tools/svgc/svgc.pro \
		examples/dwidget-examples/collections/collections.pro || die
	sed -i "s/load(dtk\(_.*\)/load(dtk2\1/g" \
		src/src.pro \
		tools/svgc/svgc.pro \
		dtkwidget.pro || die

	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" tools/svgc/svgc.pro
	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir) VERSION=${PV}
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

