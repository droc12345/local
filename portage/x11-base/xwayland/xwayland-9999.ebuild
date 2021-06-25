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

IUSE="auth bsd eglstream ipv6 rpc selinux unwind xcsecurity"

BDEPEND="
	sys-devel/flex
"
CDEPEND="
	auth? (
		>=x11-apps/iceauth-1.0.2
		>=x11-apps/xauth-1.0.3
	)
	bsd? ( dev-libs/libbsd )
	media-libs/libglvnd[X]
	media-libs/mesa[X,wayland]
	x11-apps/xkbcomp
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libpciaccess-0.12.901
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont2-2.0.1
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-misc/xbitmaps-1.0.1
	>=dev-libs/wayland-1.3.0
	>=dev-libs/wayland-protocols-1.18
	eglstream? (
		gui-libs/egl-wayland
		gui-libs/eglexternalplatform
	)
	>=media-libs/libepoxy-1.5.4[X,egl(+)]
	rpc? ( net-libs/libtirpc )
	selinux? (
		>=sys-libs/libselinux-2.9.86
		sys-process/audit
	)
	unwind? ( sys-libs/libunwind )
	x11-apps/xkbcomp
	>=x11-base/xorg-proto-2018.4
	>=x11-libs/libXfont2-2.0.0
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-libs/xtrans-1.3.5
"

DEPEND="${CDEPEND}
	!x11-base/xorg-server[wayland]
"

RDEPEND="${CDEPEND}"

PATCHES=( "${FILESDIR}"/xwayland-drop-redundantly-installed-files.patch )

# set xwayland_path only if xorg-server is installed
src_configure() {
	local emesonargs=(
		$(meson_use eglstream xwayland_eglstream)
		$(meson_use ipv6)
		$(meson_use rpc secure-rpc)
		$(meson_use unwind libunwind)
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

