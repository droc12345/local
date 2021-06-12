# WMNut ebuild script for Gentoo Linux
# Copyright (c) 2003 Arnaud Quette arnaud.quette@free.fr
# Distributed under the terms of the GNU General Public License v2

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="WMNut is a wmaker dock app that displays UPS statistics from NUT's upsd."
SRC_URI="http://wmnut.tuxfamily.org/files/${P}.tar.bz2"
HOMEPAGE="http://wmnut.tuxfamily.org/"
KEYWORDS="amd64 x86 sparc "
LICENSE="GPL-2"
SLOT="0"

#DEPEND="virtual/x11"

src_prepare() {
    epatch "${FILESDIR}"/wmnut-0.62-lib64.patch
}

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install () {
	einstall || die "make install failed"
}
