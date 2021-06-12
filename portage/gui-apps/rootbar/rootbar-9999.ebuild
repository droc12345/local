# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson
if [ "${PV}" = 9999 ]
then
	inherit mercurial
	EHG_REPO_URI="https://hg.sr.ht/~scoopta/${PN}"
fi

DESCRIPTION="Rootbar is a bar program for wlroots based wayland compositors like sway"
HOMEPAGE="https://hg.sr.ht/~scoopta/rootbar"
LICENSE="GPL-3"

#IUSE="+run +drun +dmenu"

DEPEND="
	dev-libs/wayland
	x11-libs/gtk+:3[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

RESTRICT="test mirror"

SLOT="0"

src_configure() {
	meson_src_configure
}
