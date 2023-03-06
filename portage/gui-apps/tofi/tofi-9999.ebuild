# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/philj56/tofi.git"
else
	SRC_URI="https://github.com/philj56/tofi/releases/tag/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi
inherit meson xdg

DESCRIPTION="Tiny dynamic menu/launcher for wlroots based wayland compositors"
HOMEPAGE="https://github.com/philj56/tofi"
LICENSE="GPL-3"

SLOT="0"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/freetype
	media-libs/harfbuzz
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
meson_src_configure
}

RESTRICT="mirror"
