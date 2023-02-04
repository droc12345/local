# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

DESCRIPTION="CoreFreq is a CPU monitoring software designed for the 64-bits Processors."
HOMEPAGE="https://github.com/cyring/CoreFreq"
SRC_URI="https://github.com/cyring/CoreFreq/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/${PN}-Makefile.diff
)

MODULE_NAMES="corefreqk(extra:${S}:${S})"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR} V=1 KBUILD_VERBOSE=1"
}

src_unpack(){
	default
	mv CoreFreq-${PV} ${P}
}

src_compile(){
	set_arch_to_kernel
	default
}

src_install(){
	emake PREFIX="${D}/usr" install
	linux-mod_src_install
	einstalldocs
}
