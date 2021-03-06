# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/compton/compton-0.1_beta2.ebuild,v 1.1 2013/12/14 11:38:28 hasufell Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="http://github.com/chjj/compton"
SRC_URI="https://github.com/chjj/compton/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus +drm opengl +pcre xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="dev-libs/libconfig
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre:3 )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	x11-base/xorg-proto
	drm? ( x11-libs/libdrm )"

nobuildit() { use $1 || echo yes ; }

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-export CC
	fi
}

src_compile() {
	emake docs

	NO_DBUS=$(nobuildit dbus) \
	NO_XINERAMA=$(nobuildit xinerama) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		emake compton
}

src_install() {
	NO_DBUS=$(nobuildit dbus) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		default
	docinto examples
	dodoc compton.sample.conf
}
