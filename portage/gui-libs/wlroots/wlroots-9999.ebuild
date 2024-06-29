# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
#HOMEPAGE="https://github.com/swaywm/wlroots"
HOMEPAGE="https://gitlab.freedesktop.org/wlroots/wlroots"

if [[ ${PV} == 9999 ]]; then
#	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
	EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}.git"
#	EGIT_COMMIT="252b2348bd62170d97c4e81fb2050f757b56d67e"
	inherit git-r3
	SLOT="0/9999"
else
#	SRC_URI="https://github.com/swaywm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${PV}/${PN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
	SLOT="0/15"
fi

LICENSE="MIT"
IUSE="X drm examples gles2 libinput vulkan xwayland xcb-errors"

REQUIRED_USE="
	xcb-errors? ( X )
"

DEPEND="
	>=dev-libs/libinput-1.19.0:0=
	>=dev-libs/wayland-1.20.0
	>=dev-libs/wayland-protocols-1.25
	media-libs/mesa
	sys-auth/seatd:=
	virtual/libudev
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	X? (
		|| ( x11-base/xorg-server[wayland] x11-base/xwayland )
		x11-libs/libxcb
		x11-libs/xcb-util-image
		x11-libs/xcb-util-wm
	)
	xcb-errors? ( x11-libs/xcb-util-errors )
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.25
	>=dev-build/meson-0.58.1
	virtual/pkgconfig
"

src_configure() {
	# xcb-util-errors is not on Gentoo Repository (and upstream seems inactive?)
	# but I have the ebuild in local repo -- x11-libs/xcb-util-errors.
	local emesonargs=(
		-Ddefault_library=static
		-Dxcb-errors=$(usex xcb-errors enabled disabled)
		"-Dexamples=$(usex examples true false)"
		"-Dwerror=false"
		-Drenderers=gles2,vulkan
		-Dxwayland=$(usex xwayland enabled disabled)
		-Dbackends=drm,libinput
	)

	meson_src_configure
}

pkg_postinst() {
	elog "You must be in the input group to allow your compositor"
	elog "to access input devices via libinput."
}

