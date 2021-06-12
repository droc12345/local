# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="plugins for wayfire"
HOMEPAGE="https://github.com/ammen99/wayfire-plugins"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ammen99/wayfire-plugins.git"
else
	SRC_URI="https://github.com/WayfireWM/wayfire-plugins-extra/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	gui-libs/wlroots
	gui-libs/wf-config
	gui-wm/wayfire
"
RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
