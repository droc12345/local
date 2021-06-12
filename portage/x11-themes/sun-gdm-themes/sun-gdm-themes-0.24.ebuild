# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Sun Microsystems, Inc. GDM themes"
HOMEPAGE="http://www.sun.com"
SRC_URI="http://dlc.sun.com/osol/jds/downloads/extras/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6 >=gnome-base/gdm-2.16.1"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
}

