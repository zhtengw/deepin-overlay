# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="Deepin System Monitor"
HOMEPAGE="https://github.com/linuxdeepin/deepin-system-monitor/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="sys-process/procps
	sys-libs/libcap
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtdbus:5
	dev-qt/qtx11extras:5
	x11-libs/xcb-util
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libXtst
	sys-libs/ncurses
	net-libs/libpcap
	"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		dde-base/dtkwm:=
		"

PATCHES=(
	"${FILESDIR}"/${PN}-5.0.0-qt5.14.patch
	"${FILESDIR}"/5.6.1-u_errorName.patch
)

src_prepare() {
	sed -i "/<DMenu>/a\#include\ <QKeyEvent>" \
		src/gui/system_service_table_view.cpp \
		src/gui/process_table_view.cpp || die
	sed -i "/<QDebug>/a\#include\ <QUrl>" \
		src/process/stats_collector.cpp || die
	sed -i "s/print_err/print_err1/g" \
		src/process/system_stat.cpp || die
	sed -i "s/print_err/print_err2/g" \
		src/process/desktop_entry_stat.cpp || die
	default
	QT_SELECT=qt5 eqmake5 PREFIX=/usr DEFINES+="VERSION=${PV}" ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

pkg_postinst() {
	setcap cap_kill,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+ep /usr/bin/${PN}
}
