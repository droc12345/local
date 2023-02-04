# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/LBCrion/sfwbar/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64"
    S="${WORKDIR}/${PN}"
else
    inherit git-r3
    EGIT_REPO_URI="https://github.com/LBCrion/sfwbar"
fi

DESCRIPTION="Sway Floating Window Bar"
HOMEPAGE="https://github.com/LBCrion/sfwbar"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.22.0:3[introspection,wayland]
	gui-libs/gtk-layer-shell
	dev-libs/json-c
	dev-util/wayland-scanner
	>=dev-libs/wayland-protocols-1.17
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"
