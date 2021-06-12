# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="suid program that helps to implement a workaround for using modesetting driver under rootless xorg"
HOMEPAGE="https://github.com/gch1p/drm_master_util"
EGIT_REPO_URI="https://github.com/gch1p/drm_master_util.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

MY_PN="drm_master_util"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
   tc-export PKG_CONFIG
   local LIBDRM_CFLAGS="$(${PKG_CONFIG} --cflags libdrm)"
   local LIBDRM_LIBS="$(${PKG_CONFIG} --libs libdrm)"
   $(tc-getCC) -o ${MY_PN} ${CPPFLAGS} ${LIBDRM_CFLAGS} ${CFLAGS} \
      ${LDFLAGS} drm_master_util.c ${LIBDRM_LIBS} ||
      die "Could not compile ${PN}"
}

src_install() {
	dobin "${S}"/${MY_PN}
}

pkg_postinst() {
	fperms 4755 /usr/bin/${MY_PN}
}
