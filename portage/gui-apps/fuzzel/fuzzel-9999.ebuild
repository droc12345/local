# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson xdg

DESCRIPTION="Application launcher similar to rofi's 'drun' mode"
HOMEPAGE="https://codeberg.org/dnkl/yambar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel"
else
	SRC_URI="https://codeberg.org/dnkl/fuzzel/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cairo png svg"

RDEPEND="
	dev-libs/wayland
	media-libs/fcft
	x11-libs/libxkbcommon
	x11-libs/pixman
	cairo? ( x11-libs/cairo )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
"
DEPEND="${RDEPEND}
	dev-libs/tllist
"
BDEPEND="
	app-text/scdoc
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dpng-backend=$(usex png libpng none)
		-Dsvg-backend=$(usex svg librsvg none)
		$(meson_feature cairo enable-cairo)
	)
	meson_src_configure
}
