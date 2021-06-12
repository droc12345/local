# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

XORG_MULTILIB=yes
inherit xorg-3

DESCRIPTION="XCB utility library that gives human readable names to error codes."
HOMEPAGE="https://xcb.freedesktop.org/ https://gitlab.freedesktop.org/xorg/lib/libxcb-errors"
SRC_URI="https://xcb.freedesktop.org/dist/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=x11-libs/libxcb-1.9.1:=[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf
}

# there is nothing to compile for this package, all its contents are produced by
# configure. the only make job that matters is make install
multilib_src_compile() { true; }
