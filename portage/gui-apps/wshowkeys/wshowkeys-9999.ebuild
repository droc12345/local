# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Displays keypresses on screen, wayland variant"
HOMEPAGE="https://git.sr.ht/~sircmpwn/wshowkeys"

EGIT_REPO_URI="https://github.com/ammgws/wshowkeys"

LICENSE="MIT"
SLOT="0/9999"
IUSE=""

BDEPEND="
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/wayland-protocols
	virtual/udev
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"

src_install() {
	meson_src_install
	chmod a+s "${D}/usr/bin/wshowkeys"
}
