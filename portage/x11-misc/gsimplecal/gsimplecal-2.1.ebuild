# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit autotools

DESCRIPTION="A lightweight calendar designed for tint2"
HOMEPAGE="https://github.com/dmedvinsky/gsimplecal"
SRC_URI="https://github.com/dmedvinsky/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
#RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=dev-build/autoconf-2.65"

S=$WORKDIR/$PF

PATCHES=(
	"${FILESDIR}"/sysctl.patch
)

#src_configure() {
#	econf "--enable-gtk2"
#}

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS ChangeLog
}
