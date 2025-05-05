# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson git-r3

DESCRIPTION="Wayland stacking compositor"
HOMEPAGE="https://codeberg.org/vyivel/croissant.git"

#EGIT_REPO_URI="https://codeberg.org/vyivel/croissant"
EGIT_REPO_URI="file:///n/don/git/croissant"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/libxml2:2
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
src_install() {
	meson_src_install --skip-subprojects
}

src_configure() {
	local emesonargs=(
		--wrap-mode=default
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

