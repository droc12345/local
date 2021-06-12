# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils toolchain-funcs xdg

MY_PV=$(ver_cut 1-2)
VIDEOS_PV=2.2
VIDEOS_P=${PN}-videos-${VIDEOS_PV}.wz
DESCRIPTION="3D real-time strategy game"
HOMEPAGE="http://wz2100.net/"
SRC_URI="mirror://sourceforge/warzone2100/releases/${PV}/${PN}_src.tar.xz -> ${P}.tar.xz
	videos? ( mirror://sourceforge/warzone2100/warzone2100/Videos/${VIDEOS_PV}/high-quality-en/sequences.wz -> ${VIDEOS_P} )"

LICENSE="GPL-2+ CC-BY-SA-3.0 public-domain"
SLOT="0"
#[[ "${PV}" == *_beta* ]] || \
KEYWORDS="~amd64 ~x86"
# upstream requested debug support
IUSE="debug discord nls videos"

# TODO: unbundle miniupnpc and quesoglc
# quesoglc-0.7.2 is buggy: http://developer.wz2100.net/ticket/2828
CDEPEND="
	>=dev-games/physfs-2[zip]
	>=dev-libs/libsodium-1.0.14
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/freetype:2
	media-libs/glew:=
	media-libs/harfbuzz
	media-libs/libogg
	media-libs/libpng:0
	media-libs/libsdl2[opengl,video,X]
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/openal
	sys-libs/zlib
	virtual/glu
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXrandr
	nls? ( virtual/libintl )
"
DEPEND="
	${CDEPEND}
	app-text/asciidoc
	dev-libs/fribidi
	media-libs/fontconfig
"
RDEPEND="
	${CDEPEND}
	media-fonts/dejavu
"
BDEPEND="
	app-arch/zip
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

S="${WORKDIR}/${PN}"

src_prepare() {
	default

	sed -i -e 's/#top_builddir/top_builddir/' po/Makevars || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DISCORD="$(usex discord)"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	asciidoc -b html5 doc/quickstartguide.asciidoc || die
	#asciidoc -b docbook45 doc/warzone2100.6.asciidoc || die
}

src_install() {
	local HTML_DOCS=( doc/quickstartguide.html )
	cmake-utils_src_install

	if use videos ; then
		insinto /usr/share/${PN}
		newins "${DISTDIR}"/${VIDEOS_P} sequences.wz
	fi
	#doman doc/warzone2100.6
	#insinto /usr/bin
	#dobin "${BUILD_DIR}"/src/${PN}
	#die
}


pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
