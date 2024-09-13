# Copyright 2021 Aisha Tammy
# Distributed under the terms of the ISC License

EAPI=7

inherit meson

DESCRIPTION="Box alternative for wayland"
HOMEPAGE="https://github.com/droc12345/boxland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
#	EGIT_REPO_URI="https://github.com/droc12345/boxland"
#	EGIT_COMMIT="ad15c0474db518ece55846ef624fa2d85358d89e"
#	EGIT_BRANCH="scene-graph"
	EGIT_REPO_URI="file:///n/don/git/boxland"
#	EGIT_BRANCH="ws-win-switch"
	KEYWORDS="amd64"
else
	COMMIT=64b6c37e7c2f6057000b36d530046b2b084283df
	SRC_URI="https://github.com/droc12345/boxland/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+X +system-wlroots"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/libxml2:2
	system-wlroots? ( gui-libs/wlroots )
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	X? (
		x11-base/xwayland
		x11-libs/libxcb:0=
		x11-libs/xcb-util-image
		x11-libs/xcb-util-renderutil
		x11-libs/xcb-util-wm
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
src_install() {
	meson_src_install --skip-subprojects
}

#		-Wno-error=stringop-overflow
#		-Db_sanitize=address,undefined
src_configure() {
	local emesonargs=(
		--wrap-mode=default
		$(meson_feature X xwayland)
	)
	if ! use system-wlroots; then
		emesonargs+=(--force-fallback-for=wlroots)
	fi

	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
