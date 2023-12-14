# Copyright 2022 Aisha Tammy <floss@bsd.ac>
# Distributed under the terms of the ISC License

EAPI=8

inherit toolchain-funcs meson

DESCRIPTION="Dynamic tiling Wayland compositor that doesn't sacrifice on its looks."
HOMEPAGE="https://github.com/hyprwm/Hyprland"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/Hyprland"
	#EGIT_COMMIT="7f47655f60be2c54dfa0e1758cbff20ab38217fc"
else
	MY_PV="${PV}beta"
	SRC_URI="https://github.com/hyprwm/Hyprland/releases/download/v${MY_PV}/source-v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="system-wlroots legacy-renderer X"

DEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	media-libs/glm
	media-libs/mesa:=[gles2,wayland,X?]
	media-libs/libglvnd[X?]
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/freetype:=[X?]
	>=x11-libs/libdrm-2.4.113:=
	x11-libs/gtk+:3=[wayland,X?]
	x11-libs/cairo:=[X?,svg(+)]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pixman
	X? (
		x11-libs/libxcb
		x11-base/xwayland
	)
	system-wlroots? ( gui-libs/wlroots:=[X?] )
"

RDEPEND="
	${DEPEND}
	x11-misc/xkeyboard-config
"

BDEPEND="
	>=dev-libs/wayland-protocols-1.27
	dev-libs/libliftoff
	dev-libs/udis86
	media-libs/libdisplay-info
	virtual/pkgconfig
"

src_configure() {
	tc-is-gcc && [[ $(gcc-major-version) -ge 12 ]]  && [[ $(gcc-minor-version) -ge 1 ]] || die "hyprland needs gcc version >= 12.1 for C++23"
	local emesonargs=(
		--wrap-mode=default
		$(meson_feature legacy-renderer legacy_renderer)
		$(meson_feature system-wlroots use_system_wlroots)
		$(meson_feature X xwayland)
	)
	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects
	meson_src_install --tags devel

	#mkdir ${D}/usr/include/hyprland/wlroots
	#cp -r ${S}/subprojects/wlroots/include/wlr ${D}/usr/include/hyprland/wlroots
	#rm ${D}/usr/include/hyprland/wlroots/wlr/config.h.in
	#rm ${D}/usr/include/hyprland/wlroots/wlr/meson.build
	#rm ${D}/usr/include/hyprland/wlroots/wlr/version.h.in
	#cp ${S}-build/subprojects/wlroots/include/wlr/* ${D}/usr/include/hyprland/wlroots/wlr
	mkdir "${ED}"/usr/include/hyprland/wlroots || die
	mv "${ED}"/usr/include/wlr "${ED}"/usr/include/hyprland/wlroots || die
	# devel tag includes wlroots .pc and .a files still
	rm -rf "${ED}"/usr/$(get_libdir)/ || die
}
