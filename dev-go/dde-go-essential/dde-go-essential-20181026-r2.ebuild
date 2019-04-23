# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# EGO_PN="github.com/BurntSushi/xgb github.com/BurntSushi/xgbutil github.com/howeyc/fsnotify gopkg.in/alecthomas/kingpin.v2 github.com/disintegration/imaging"
# 
# inherit golang-vcs

#inherit git-2

DESCRIPTION="Essential go sources for DDE"
HOMEPAGE="https://github.com/linuxdeepin/go-lib#installation"
SRC_URI="https://github.com/mattn/go-sqlite3/archive/v1.2.0.tar.gz -> go-sqlite3-1.2.0.tar.gz
		https://github.com/alecthomas/kingpin/archive/v2.2.3.tar.gz -> kingpin-2.2.3.tar.gz
		https://github.com/fsnotify/fsnotify/archive/v1.4.2.tar.gz -> fsnotify-1.4.2.tar.gz
		https://github.com/fogleman/gg/archive/v1.1.0.tar.gz -> gg-1.1.0.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/go"

DEPEND="${RDEPEND}
	      dev-vcs/git
	      dev-vcs/bzr"

S=${WORKDIR}

src_prepare() {
		export GOPATH=${WORKDIR}

		mkdir -p ${WORKDIR}/src/github.com/mattn/ \
				${WORKDIR}/src/gopkg.in/alecthomas/ \
				${WORKDIR}/src/github.com/fsnotify/ \
				${WORKDIR}/src/github.com/fogleman/

		cp -r ${S}/go-sqlite3-1.2.0 ${WORKDIR}/src/github.com/mattn/go-sqlite3
		cp -r ${S}/kingpin-2.2.3 ${WORKDIR}/src/gopkg.in/alecthomas/kingpin.v2
		cp -r ${S}/fsnotify-1.4.2 ${WORKDIR}/src/github.com/fsnotify/fsnotify
		cp -r ${S}/gg-1.1.0	${WORKDIR}/src/github.com/fogleman/gg

		go get -d -f -u -v gopkg.in/check.v1 \
			  golang.org/x/sys \
			  golang.org/x/net \
			  golang.org/x/image \
			  github.com/disintegration/imaging  \
			  github.com/BurntSushi/xgb \
			  github.com/BurntSushi/xgbutil \
			  github.com/alecthomas/units \
			  github.com/alecthomas/template \
			  github.com/golang/freetype \
			  github.com/BurntSushi/freetype-go \
			  github.com/BurntSushi/graphics-go \
			  github.com/axgle/mahonia \
			  github.com/nfnt/resize \
			  github.com/cryptix/wav  || die " get dependent sources failed "

}

src_install() {
	insinto /usr/share/gocode
	doins -r ${WORKDIR}/src
}
