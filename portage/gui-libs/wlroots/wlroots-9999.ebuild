# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
HOMEPAGE="https://github.com/swaywm/wlroots"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
	inherit git-r3
	SLOT="0/9999"
else
	SRC_URI="https://github.com/swaywm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
	SLOT="0/14"
fi

LICENSE="MIT"
IUSE="X examples xcb-errors drm x11 libinput gles2"

REQUIRED_USE="
	xcb-errors? ( X )
"

DEPEND="
	>=dev-libs/libinput-1.14.0:0=
	>=dev-libs/wayland-1.19.0
	>=dev-libs/wayland-protocols-1.17.0
	media-libs/mesa[egl,gles2?,gbm]
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
		xcb-errors? ( x11-libs/xcb-util-errors )
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.17
	>=dev-util/meson-0.56.0
	virtual/pkgconfig
"

src_configure() {
	# xcb-util-errors is not on Gentoo Repository (and upstream seems inactive?)
	# but I have the ebuild in local repo -- x11-libs/xcb-util-errors.
	local emesonargs=(
		-Dxcb-errors=$(usex xcb-errors enabled disabled)
		"-Dexamples=$(usex examples true false)"
		"-Dwerror=false"
		-Dxwayland=$(usex X enabled disabled)
	)

	if use drm || use x11 || use libinput; then
		if use drm; then
			MY_BKEND="${MY_BKEND} drm"
		fi
		if use x11; then
			MY_BKEND="${MY_BKEND} x11"
		fi
		if use libinput; then
			MY_BKEND="${MY_BKEND} libinput"
		fi
		emesonargs+=(
			-Dbackends="$(_meson_env_array $MY_BKEND)"
		)
	fi
	if ! use gles2; then
		emesonargs+=(
			-Drenderers="[]"
		)
	fi

	meson_src_configure
}

pkg_postinst() {
	elog "You must be in the input group to allow your compositor"
	elog "to access input devices via libinput."
}

