# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg-utils

DESCRIPTION="A lightweight notification daemon for Wayland. Works on Sway."
HOMEPAGE="https://codeberg.org/dnkl/fnott"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fnott.git"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+icons"

DEPEND="
	dev-libs/wayland
	media-libs/fcft
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	sys-apps/dbus
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-text/scdoc
	dev-libs/tllist
	dev-libs/wayland-protocols
	dev-util/ninja
	sys-libs/ncurses
"
src_configure() {
	meson_src_configure
}
