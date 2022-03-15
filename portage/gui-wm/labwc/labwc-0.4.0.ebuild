# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="Openbox alternative for wayland"
HOMEPAGE="https://github.com/labwc/labwc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/labwc/labwc"
else
	SRC_URI="https://github.com/labwc/labwc/archive/refs/tags/${PN}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+X"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/libxml2:2
	gui-libs/wlroots[X?]
	x11-libs/cairo[X?]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pango[X?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		--wrap-mode=default
		$(meson_feature X xwayland)
	)
	meson_src_configure
}
