# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools xdg-utils

DESCRIPTION="A small utility for fast and easy GUI building"
HOMEPAGE="https://github.com/v1cont/yad"
SRC_URI="https://https://github.com/v1cont/yad/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+gsettings html nls spell sourceview"

RDEPEND="
	x11-libs/gtk+:3
"
DEPEND="
	${RDEPEND}
	html? ( net-libs/webkit-gtk )
	sourceview? ( x11-libs/gtksourceview )
	spell? ( app-text/gspell )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gsettings standalone) \
		$(use_enable nls) \
		$(use_enable html) \
		$(use_enable spell) \
		$(use_enable sourceview) \
		--enable-tools \
		--enable-icon-browser \
		--enable-tools \
		--enable-tray
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
