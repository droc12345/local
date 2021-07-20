# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} = *9999* ]]; then
	EGIT_BRANCH="xwayland-21.1"
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/xserver.git"
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

IUSE="rpc libselinux unwind"

BDEPEND="
	sys-devel/flex
"
CDEPEND="
	dev-libs/libbsd
	dev-libs/wayland
	dev-libs/wayland-protocols
	gui-libs/egl-wayland
	gui-libs/eglexternalplatform
	media-libs/libepoxy[X,egl]
	media-libs/libglvnd[X]
	media-libs/mesa[X,wayland]
	rpc? ( net-libs/libtirpc )
	libselinux? (
		>=sys-libs/libselinux-2.9.86
		sys-process/audit
	)
	unwind? ( sys-libs/libunwind )
	x11-apps/iceauth
	x11-apps/xauth
	x11-apps/xkbcomp
	>=x11-base/xorg-proto-2018.4
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont2-2.0.1
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-libs/xtrans-1.3.5
	>=x11-misc/xbitmaps-1.0.1
"

DEPEND="${CDEPEND}
	!x11-base/xorg-server[wayland]
"

RDEPEND="${CDEPEND}"

PATCHES=( "${FILESDIR}"/xwayland-drop-redundantly-installed-files.patch )

# set xwayland_path only if xorg-server is installed
src_configure() {
	local emesonargs=(
		$(meson_use rpc secure-rpc)
		$(meson_use unwind libunwind)
		$(meson_use xcsecurity true)
		-Ddtrace=false
	)
	meson_src_configure
}
# ****** add this above if want to not use /usr/bin directly and uncomment dosym below ******
#		-Dxwayland-path=/usr/libexec

src_install() {
#   only do this if /usr/bin/Xwayland is a file and doesn't exist
#   -> have to investigate if can use bash/sh to find out
#	dosym ../libexec/Xwayland /usr/bin/Xwayland

	meson_src_install
}

