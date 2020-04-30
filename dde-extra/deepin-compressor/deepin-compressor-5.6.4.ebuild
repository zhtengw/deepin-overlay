# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Archive Manager for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-compressor"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtxml:5
		dev-qt/qtconcurrent:5
		dev-qt/qtx11extras:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		kde-frameworks/kcodecs
		app-text/poppler[cxx]
		app-crypt/libsecret
		x11-libs/gsettings-qt
		dev-libs/disomaster
		app-arch/libarchive
		dev-libs/libzip
		kde-frameworks/karchive
		"

DEPEND="${RDEPEND}
		dde-base/udisks2-qt5
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dtkgui-5.1.2:=
		dev-qt/linguist-tools
		virtual/pkgconfig
		"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" \
		deepin-compressor/interface/pluginmanager.cpp \
		plugin/libzipplugin/libzipplugin.pro \
		plugin/clirarplugin/clirarplugin.pro \
		plugin/cli7zplugin/cli7zplugin.pro \
		plugin/libsinglefileplugin/xzplugin/xzplugin.pro \
		plugin/libsinglefileplugin/gzplugin/gzplugin.pro \
		plugin/libsinglefileplugin/bz2plugin/bz2plugin.pro \
		plugin/clizipplugin/clizipplugin.pro \
		plugin/cliunarchiverplugin/cliunarchiverplugin.pro \
		plugin/libarchive/readwritelibarchiveplugin/readwritelibarchiveplugin.pro \
		plugin/libarchive/readonlylibarchiveplugin/readonlylibarchiveplugin.pro || die

	QT_SELECT=qt5 eqmake5 PREFIX=/usr DEFINES+="VERSION=${PV}"
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
