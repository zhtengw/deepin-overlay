# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Deepin Desktop Enviroment (meta package)"
HOMEPAGE="https://www.deepin.org"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="policykit manual +terminal terminal-old multimedia grub plymouth elogind systemd turbo kwin +mutter extra screensaver"
REQUIRED_USE="^^ ( systemd elogind )
			?? ( mutter kwin )
			?? ( terminal terminal-old )"

RDEPEND=">=dde-base/dde-control-center-5.0.33
		virtual/dde-wm[mutter?,kwin?]
		>=dde-base/startdde-5.2.1
		>=dde-base/dde-file-manager-5.1.0[screensaver?]
		>=dde-base/dde-launcher-5.0.16
		>=dde-base/dde-dock-5.0.27
		>=dde-base/deepin-desktop-base-2020.04.12
		>=dde-base/dde-session-ui-5.0.17[systemd?,elogind?]
		>=dde-base/dde-daemon-5.9.0[grub?,systemd?,elogind?]
		dde-base/dde-clipboard
		policykit? ( dde-base/dde-polkit-agent
			dde-base/dpa-ext-gnomekeyring )
		turbo? ( dde-extra/deepin-turbo[systemd?,elogind?] )
		manual? ( >=dde-extra/deepin-manual-5.6.0 )
		terminal? ( dde-extra/deepin-terminal )
		terminal-old? ( dde-extra/deepin-terminal-old )
		multimedia? ( dde-extra/dde-meta-multimedia )
		extra? ( ~dde-extra/dde-meta-apps-${PV} )
		plymouth? ( dde-extra/plymouth-theme-deepin )
		"

pkg_postinst() {
	( use terminal || use terminal-old ) && dfmterm deepin-terminal
}
