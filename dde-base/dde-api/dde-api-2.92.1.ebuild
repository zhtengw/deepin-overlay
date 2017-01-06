# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5


DESCRIPTION="Go-lang bingdings for dde-daemon"
HOMEPAGE="https://gitcafe.com/Deepin/dde-api"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gcc[go]
		x11-wm/metacity
		x11-libs/libXi
		dev-libs/glib:2
		x11-libs/gtk+:3
		x11-libs/gdk-pixbuf:2
		media-libs/libcanberra[pulseaudio]
		x11-libs/libXfixes
		net-wireless/rfkill
		app-text/poppler[cairo]
		x11-libs/libXcursor
		x11-apps/xcur2png
		gnome-base/librsvg:2
		"

DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
	      dev-go/deepin-go-lib
	      dev-go/dbus-factory
	      dev-vcs/git
	      dev-vcs/bzr"
	   

src_prepare() {
#  	  sed -i "s|\${PREFIX}/share/gocode|$(go enc GOROOT)|g" Makefile
	  export GOPATH="${S}:/usr/share/gocode"
	  
# 	  go get gitcafe.com/Deepin/go-lib
# 	  git clone https://github.com/linuxdeepin/go-lib.git
	  
# 	  mkdir -p src/pkg.deepin.io
# 	  cp -a go-lib src/pkg.deepin.io/lib
# 	  cp -a src/gitcafe.com/Deepin/go-lib src/pkg.deepin.io/lib
# 	  cp -a src/pkg.deepin.io src/pkg.linuxdeepin.com
	  
# 	  go get gitcafe.com/Deepin/dbus-factory
	  
# 	  git clone https://github.com/linuxdeepin/dbus-factory.git
	  
	  go get -d github.com/golang/image
	  mkdir -p src/golang.org/
	  mv src/github.com/golang/ src/golang.org/x
	  
# 	  make build-dep
	  go get -d launchpad.net/gocheck
}

src_compile() {
# 	  cd src/gitcafe.com/Deepin/dbus-factory
# 	  cd dbus-factory
# 	  make install-golang
# 	  
# 	  cd ${S}
	  make USE_GCCGO=1
}