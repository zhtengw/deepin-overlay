# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Control Center of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/dde-control-center"
SRC_URI="https://community-packages.deepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}+c5.orig.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd redshift"

RDEPEND="dev-qt/qtsvg:5
		dev-qt/qtsql:5
		dev-qt/qtx11extras:5
		dev-qt/qtdeclarative:5
		dev-qt/qtmultimedia:5
		dev-qt/qtconcurrent:5
		dev-qt/qtnetwork:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-libs/libqtxdg
		kde-frameworks/networkmanager-qt
		x11-libs/startup-notification
		>=dde-base/dde-daemon-5.9.5
		>=dde-base/dde-api-5.1.13
		dde-base/dde-account-faces
		>=dde-base/dde-dock-5.0.27
		dde-base/startdde
		>=dde-base/dde-network-utils-5.0.4
		dev-util/desktop-file-utils
		dev-libs/geoip
		>=dde-base/deepin-desktop-base-2020.04.12
		dde-base/dde-qt5integration
		redshift? ( x11-misc/redshift )
		!systemd? ( app-admin/openrc-settingsd )
		"
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/dde-qt-dbus-factory-5.0.16:=
		"

S="${WORKDIR}/${P}+c5"

PATCHES=(
	"${FILESDIR}/5.0.33-missing-include.patch"
)

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|DESTINATION\ lib|DESTINATION\ ${LIBDIR}|g" \
		src/dialogs/CMakeLists.txt \
		src/frame/CMakeLists.txt || die
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" \
		src/frame/modules/sync/syncworker.cpp \
		src/frame/modules/update/updatework.cpp || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DDISABLE_SYS_UPDATE=YES
	)
	cmake-utils_src_configure
}

