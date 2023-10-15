# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/LBCrion/sfwbar/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64"
    S="${WORKDIR}/${PN}"
else
    inherit git-r3
    EGIT_REPO_URI="https://github.com/LBCrion/sfwbar"
fi

DESCRIPTION="S* Floating Window Bar"
HOMEPAGE="https://github.com/LBCrion/sfwbar"

LICENSE="GPL-3"
SLOT="0"
IUSE="X mpd pulseaudio alsa"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/json-c:=
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	>=x11-libs/gtk+-3.22.0:3[introspection,wayland]
	X? ( x11-libs/libxkbcommon )
	mpd? ( media-libs/libmpdclient )
	pulseaudio? ( media-libs/libpulse[glib] )
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${COMMON_DEPEND}
	virtual/freedesktop-icon-theme
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/wayland-protocols-1.17
"
BDEPEND="dev-util/wayland-scanner"

src_configure() {
	local emesonargs=(
		$(meson_feature alsa)
		$(meson_feature mpd)
		$(meson_feature pulseaudio pulse)
		$(meson_feature X xkb)
		-Dnetwork=disabled
		-Didleinhibit=enabled
		-Dbluez=disabled
		-Dbsdctl=disabled
	)

	meson_src_configure
}
