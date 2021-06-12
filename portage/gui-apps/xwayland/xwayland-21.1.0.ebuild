# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/xserver/-/tree/xwayland-21.1"
	inherit git-r3
else
	SRC_URI="https://www.x.org/releases/individual/xserver/${P}.tar.xz"
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc x86"
fi
inherit meson

DESCRIPTION="Xwayland standalone server"
HOMEPAGE="https://xorg.freedesktop.org/ https://gitlab.freedesktop.org/xorg/xserver"

LICENSE="MIT"
SLOT="0"

IUSE="eglstream rpc unwind"

CDEPEND="
	dev-libs/openssl:0=
	x11-apps/xkbcomp
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-libs/xtrans-1.3.5
	>=media-libs/libepoxy-1.5.4[X,egl(+)]
	>=dev-libs/wayland-1.3.0
	>=media-libs/libepoxy-1.5.4[egl(+)]
	>=dev-libs/wayland-protocols-1.18
	eglstream? ( gui-libs/egl-wayland )
	unwind? ( sys-libs/libunwind )
	rpc? ( net-libs/libtirpc )
"

DEPEND="${CDEPEND}
	>=x11-base/xorg-proto-2018.4"

RDEPEND="${CDEPEND}"

PATCHES=( "${FILESDIR}"/meson.patch )

src_configure() {
	local emesonargs=(
		$(meson_use unwind libunwind)
		$(meson_use rpc secure-rpc)
		$(meson_use eglstream xwayland_eglstream)
		-Dxwayland-path="/usr/libexec"
	)
	meson_src_configure
}

