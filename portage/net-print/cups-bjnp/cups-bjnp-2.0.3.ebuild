# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="CUPS backend for the canon printers using the proprietary USB over IP BJNP protocol"
HOMEPAGE="https://sourceforge.net/projects/cups-bjnp/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_configure() {
	econf --disable-Werror
}
