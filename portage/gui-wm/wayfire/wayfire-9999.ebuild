# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
#	EGIT_COMMIT="e1f8f78a49108e4a820f1b5735f2284796239a03"
#	EGIT_REPO_URI="file:///var/portage/distfiles/git3-src/WayfireWM_wayfire.git"
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
else
	SRC_URI="https://github.com/WayfireWM/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+gles +system-wfconfig +system-wlroots X"

DEPEND="
	dev-libs/glib:2
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/yyjson
	gui-libs/gtk-layer-shell
	media-libs/glm
	media-libs/mesa
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/freetype
	x11-libs/libdrm
	x11-libs/gtk+:3
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pixman
	X? ( x11-libs/libxcb )
	system-wfconfig? ( gui-libs/wf-config )
	system-wlroots? ( gui-libs/wlroots )
"

RDEPEND="
	${DEPEND}
	x11-misc/xkeyboard-config
"

BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_configure() {
	sed -e "s:@EPREFIX@:${EPREFIX}:" \
		"${FILESDIR}"/wayfire-session > "${T}"/wayfire-session || die
	sed -e "s:@EPREFIX@:${EPREFIX}:" \
		"${FILESDIR}"/wayfire-session.desktop > "${T}"/wayfire-session.desktop || die
	local emesonargs=(
		$(meson_feature system-wfconfig use_system_wfconfig)
		$(meson_feature system-wlroots use_system_wlroots)
		$(meson_feature X xwayland)
		$(meson_use gles enable_gles32)
	)
	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects
	dobin "${T}"/wayfire-session

	insinto "/usr/share/wayland-sessions/"
	insopts -m644
	doins wayfire.desktop
	doins "${T}"/wayfire-session.desktop

	insinto "/usr/share/wayfire/"
	doins wayfire.ini
}

pkg_postinst() {
	if [ -z "${REPLACING_VERSIONS}" ]; then
		elog "Wayfire has been installed but the session cannot be used"
		elog "until you install a configuration file. The default config"
		elog "file is installed at \"/usr/share/wayfire/wayfire.ini\""
		elog "To install the file execute"
		elog "\$ cp /usr/share/wayfire.ini ~/.config/wayfire.ini"
	fi
}
