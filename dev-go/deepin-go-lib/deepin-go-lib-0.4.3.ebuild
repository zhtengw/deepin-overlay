# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# EGO_PN="github.com/BurntSushi/xgb github.com/BurntSushi/xgbutil github.com/howeyc/fsnotify gopkg.in/alecthomas/kingpin.v2 github.com/disintegration/imaging"
# 
# inherit golang-vcs

DESCRIPTION="Deepin GoLang Library"
HOMEPAGE="https://gitcafe.com/Deepin/go-lib"
SRC_URI="https://github.com/linuxdeepin/go-lib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		dev-lang/go"

DEPEND="${RDEPEND}
	      dev-vcs/git
	      dev-vcs/bzr"
	
S=${WORKDIR}/go-lib-${PV}

src_prepare() {
		export GOPATH=${WORKDIR}
		
		mkdir -p ${WORKDIR}/src/pkg.deepin.io/
		cp -r ${S}  ${WORKDIR}/src/pkg.deepin.io/lib
		
		go get -d -f -u -v gopkg.in/alecthomas/kingpin.v2 	\
			  github.com/BurntSushi/xgb \
			  github.com/BurntSushi/xgbutil \
			  github.com/howeyc/fsnotify	\
			  github.com/disintegration/imaging  \
			  launchpad.net/gocheck \
			  github.com/mattn/go-sqlite3 || die " get dependent sources failed "

}

src_install() {
	insinto /usr/share/gocode
	doins -r ${WORKDIR}/src
}