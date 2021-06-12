# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A simple wallpaper utility for Wayland"
HOMEPAGE="https://codeberg.org/dnkl/wbg"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/droc12345/${PN}.git"
else
	SRC_URI="https://codeberg.org/dnkl/tllist/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	x11-libs/pixman
	|| ( media-libs/libpng virtual/jpeg )
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-libs/tllist
	virtual/pkgconfig
"

src_configure() {
	meson_src_configure
}
