# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal libtool

MY_P="gc-${PV}"

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://www.hboehm.info/gc/ https://github.com/ivmai/bdwgc/"
SRC_URI="https://github.com/ivmai/bdwgc/releases/download/v${PV}/${MY_P}.tar.gz
	https://dev.gentoo.org/~xen0n/distfiles/${P}-fix-headers-install.patch.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="boehm-gc"
# SONAME: libgc.so.1 libgccpp.so.1
# We've been using subslot 0 for these instead of "1.1".
SLOT="0"
# Upstream marked this version as "Pre-release"
KEYWORDS="~loong"
IUSE="cxx +large static-libs +threads"

RDEPEND=">=dev-libs/libatomic_ops-7.4[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${WORKDIR}/${P}-fix-headers-install.patch"
)

src_prepare() {
	default
	elibtoolize #594754
}

multilib_src_configure() {
	local config=(
		--disable-docs
		--with-libatomic-ops
		$(use_enable cxx cplusplus)
		$(use_enable static-libs static)
		$(use threads || echo --disable-threads)
		$(use_enable large large-config)
	)

	ECONF_SOURCE=${S} econf "${config[@]}"
}

multilib_src_install_all() {
	local HTML_DOCS=( doc/*.md )
	einstalldocs
	dodoc doc/README{.environment,.linux,.macros}

	# package provides .pc files
	find "${ED}" -name '*.la' -delete || die

	newman doc/gc.man GC_malloc.1
}
