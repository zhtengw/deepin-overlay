# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Fast File Search Tool for DDE"
HOMEPAGE="https://github.com/linuxdeepin/deepin-anything"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/glibc"


src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|<sys/types.h>|<sys/sysmacros.h>|g" library/src/walkdir.c
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" Makefile

	default_src_prepare
}

src_compile() {
	emake VERSION=${PV}
}
