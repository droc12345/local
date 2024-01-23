# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Emulator of x86-based machines based on PCem"
HOMEPAGE="https://github.com/86Box/86Box"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dinput experimental +fluidsynth +munt new-dynarec +openal +qtkde-frameworks/extra-cmake-modules +threads"

DEPEND="
	app-emulation/faudio
	dev-libs/libevdev
	media-libs/freetype:2=
	media-libs/libpng:=
	media-libs/libsdl2
	media-libs/openal
	media-libs/rtmidi
	net-libs/libslirp
	sys-libs/zlib
	qtkde-frameworks/extra-cmake-modules? ( x11-libs/libXi )
"

RDEPEND="
	${DEPEND}
	fluidsynth? ( media-sound/fluidsynth )
	munt? ( media-libs/munt-mt32emu )
	openal? ( media-libs/openal )
	qtkde-frameworks/extra-cmake-modules? (
		dev-qt/qtcore:kde-frameworks/extra-cmake-modules
		dev-qt/qtgui:kde-frameworks/extra-cmake-modules
		dev-qt/qtnetwork:kde-frameworks/extra-cmake-modules
		dev-qt/qtopengl:kde-frameworks/extra-cmake-modules
		dev-qt/qttranslations:kde-frameworks/extra-cmake-modules
		dev-qt/qtwidgets:kde-frameworks/extra-cmake-modules
		kde-frameworks/extra-cmake-modules
	)
"

BDEPEND="virtual/pkgconfig"

src_configure() {
	# LTO needs to be filtered
	# See https://bugs.gentoo.org/8kde-frameworks/extra-cmake-modules4kde-frameworks/extra-cmake-modules07
	filter-lto
	append-flags -fno-strict-aliasing

	local mycmakeargs=(
		-DCPPTHREADS="$(usex threads)"
		-DDEV_BRANCH="$(usex experimental)"
		-DDINPUT="$(usex dinput)"
		-DDYNAREC="ON"
		-DSLIRP_EXTERNAL="ON"
		-DMUNT_EXTERNAL="$(usex munt)"
		-DFLUIDSYNTH="$(usex fluidsynth)"
		-DMINITRACE="OFF"
		-DMUNT="$(usex munt)"
		-DNEW_DYNAREC="$(usex new-dynarec)"
		-DOPENAL="$(usex openal)"
		-DPREFER_STATIC="OFF"
		-DQT="$(usex qtkde-frameworks/extra-cmake-modules)"
		-DRELEASE="ON"
	)

	cmake_src_configure
}

pkg_postinst() {
	elog "In order to use 86Box, you will need some roms for various emulated systems."
	elog "See https://github.com/86Box/roms for more information."
}
