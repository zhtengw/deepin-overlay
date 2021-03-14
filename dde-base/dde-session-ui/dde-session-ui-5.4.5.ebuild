# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils gnome2-utils

DESCRIPTION="Deepin desktop environment - Session UI module"
HOMEPAGE="https://github.com/linuxdeepin/dde-session-ui"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd elogind"
REQUIRED_USE="^^ ( systemd elogind )"

RDEPEND="
		 x11-libs/gsettings-qt
		 x11-misc/lightdm[qt5]
		 x11-libs/libXext
		 x11-libs/libXtst
		 x11-libs/libX11
		 x11-libs/libXcursor
		 x11-libs/libXfixes
		 x11-apps/xrandr
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtdbus:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtsvg:5
		 >=dde-base/dde-daemon-5.9.0[systemd?,elogind?]
		 >=dde-base/deepin-desktop-schemas-5.4.0
		 >=dde-base/startdde-5.2.1
		 >=dde-base/dde-dock-5.0.27
		 dde-base/dde-session-shell
		"
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
		>=dde-base/deepin-gettext-tools-1.0.6
		>=dde-base/dde-qt-dbus-factory-1.1.5:=
		virtual/pkgconfig
		"


src_prepare() {

	sed -i "/<QPainter>/a#include <QPainterPath>" \
		dde-notification-plugin/notifications/notificationswidget.cpp \
		dde-osd/common.h || die
	sed -i "/<QTimer>/a#include <QPainterPath>" \
		dde-osd/notification-center/overlapwidet.cpp || die

	if use elogind; then
		sed -i "s|libsystemd|libelogind|g" dde-switchtogreeter/dde-switchtogreeter.pro || die
		sed -i "s|systemd/sd-login.h|elogind/systemd/sd-login.h|g" dde-switchtogreeter/switchtogreeter.c || die
	fi

	LIBDIR=$(get_libdir)
	sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" \
		d*/*.pro \
		d*/*.service \
		dde-osd/notification/files/*.service.in \
		misc/applications/deepin-toggle-desktop.desktop.in || die
	sed -i "s|/lib/|/${LIBDIR}/|g" \
		dde-notification-plugin/notifications/notifications.pro || die
	QT_SELECT=qt5 eqmake5 PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
