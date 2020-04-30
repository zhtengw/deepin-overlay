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
SLOT="2/${PV}"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.5:5
		dev-qt/qtdbus
		dev-qt/qttest
		x11-libs/gsettings-qt
	    "
DEPEND="${RDEPEND}"

src_prepare() {
	cd ${S}/cmake
	sed -i "s/DtkCore/DtkCore2/" DtkCMake/DtkCMakeConfig.cmake || die
	sed -i "s/DTKCORE/DTKCORE2/" DtkCMake/DtkCMakeConfig.cmake || die
	mv Dtk/DtkConfig.cmake Dtk/Dtk2Config.cmake
	mv DtkCMake/DtkCMakeConfig.cmake DtkCMake/Dtk2CMakeConfig.cmake
	mv Dtk Dtk2
	mv DtkCMake Dtk2CMake

	cd ${S}
	sed -i "s/\(TARGET\ =\ dtkcore\)/\12/" src/src.pro || die
	sed -i "s/dtkcore/dtkcore2/g" \
		src/dtk_qmake.prf \
		src/dtk_build.prf \
		src/dtkcore_global.h \
		dtk_build_config.prf \
		tools/settings/settings.pro \
		tools/deepin-os-release/deepin-os-release.pro || die

	sed -i "s/dtk\(_.*\)/dtk2\1/g" \
		src/dtk_build.prf \
		src/src.pro \
		dtkcore.pro \
		tools/settings/settings.pro \
		tools/deepin-os-release/deepin-os-release.pro || die
	mv dtk_build_config.prf dtk2_build_config.prf

	cd ${S}/src
	for prf in $(ls dtk_*.prf)
	do
		newprf=dtk2_${prf#dtk_}
		mv $prf $newprf 
	done

	cd ${S}
	LIBDIR=$(get_libdir)
	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir) VERSION=${PV}
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

