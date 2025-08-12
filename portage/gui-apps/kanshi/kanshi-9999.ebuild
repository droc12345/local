# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="dynamic display configuration (autorandr for wayland)"
#HOMEPAGE="https://git.sr.ht/~emersion/kanshi"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/kanshi"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/emersion/kanshi"
else
	SRC_URI="https://gitlab.freedesktop.org/emersion/kanshi/-/archive/v${PV}/kanshi-v${PV}.tar.bz2"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+man +ipc"

RDEPEND="
	dev-libs/libscfg
	dev-libs/wayland
	man? ( ~app-text/scdoc-9999 )
	ipc? ( dev-libs/libvarlink )
"
BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature ipc)
	)
	meson_src_configure
}
