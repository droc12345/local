# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools xdg-utils

DESCRIPTION="A small utility for fast and easy GUI building"
HOMEPAGE="https://github.com/oshazard/gtkdialog"
SRC_URI="https://dev.gentoo.org/~jer/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk2 vte"

RDEPEND="
	gtk2? (
		x11-libs/gtk+:2
		vte? ( x11-libs/vte:0= )
	)
	!gtk2? (
		x11-libs/gtk+:3
		vte? ( x11-libs/vte:2.91= )
	)
"
DEPEND="
	${RDEPEND}
	sys-apps/texinfo
	sys-devel/flex
	virtual/pkgconfig
	app-alternatives/yacc
"
PATCHES=(
	"${FILESDIR}"/${PN}-0.8.3-fno-common.patch
	"${FILESDIR}"/${PN}-0.8.3-do_variables_count_widgets.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(usex gtk2 --disable-gtk3  --enable-gtk3) $(use_with vte)
}

src_compile() {
	emake -C doc stamp-vti
	default
}

src_install() {
	# Stop make install from running gtk-update-icon-cache
	emake DESTDIR="${D}" UPDATE_ICON_CACHE=true install
	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
