# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin - Core modules"
HOMEPAGE="https://github.com/linuxdeepin/dtkcore"

if [[ "${PV}" == *9999* ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
   	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.5:5
		dev-qt/qtdbus
		dev-qt/qttest
		x11-libs/gsettings-qt
	    "
DEPEND="${RDEPEND}"

src_prepare() {
	LIBDIR=$(get_libdir)

	sed -i "s/\(dtk_.*\).prf/\1-2.prf/g" \
		src/src.pro \
		dtkcore.pro \
		tools/settings/settings.pro \
		tools/deepin-os-release/deepin-os-release.pro || die
	mv dtk_build_config.prf dtk_build_config-2.prf
	for prf in $(ls src/dtk_*.prf)
	do
		newprf=${prf%.prf}-2.prf
		mv $prf $newprf 
	done

	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir) VERSION=${PV}
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

