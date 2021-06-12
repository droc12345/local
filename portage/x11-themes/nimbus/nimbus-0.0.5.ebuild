# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Sun Microsystems, Inc. default theme"
HOMEPAGE="http://www.sun.com"
SRC_URI="http://dlc.sun.com/osol/jds/downloads/extras/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6"

PATCHES="${FILESDIR}/${P}-configure.patch"

src_unpack() {
	unpack ${A}
	cd "${S}"

	patch configure ${FILESDIR}/${P}-configure.patch || die

}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
}

