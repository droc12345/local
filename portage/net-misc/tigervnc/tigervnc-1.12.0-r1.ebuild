# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1
inherit autotools cmake flag-o-matic java-pkg-opt-2 systemd xdg

XSERVER_VERSION="21.1.1"

DESCRIPTION="Remote desktop viewer display system"
HOMEPAGE="http://www.tigervnc.org"
SRC_URI="https://github.com/TigerVNC/tigervnc/archive/v${PV}.tar.gz -> ${P}.tar.gz
	server? (
		ftp://ftp.freedesktop.org/pub/xorg/individual/xserver/xorg-server-${XSERVER_VERSION}.tar.xz
		https://github.com/TigerVNC/tigervnc/commit/0c5a2b2e7759c2829c07186cfce4d24aa9b5274e.patch -> ${P}-xserver-21.patch
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="dri3 +drm gnutls java nls +opengl server xinerama xorgmodule"

CDEPEND="
	virtual/jpeg:0
	sys-libs/zlib:=
	>=x11-libs/fltk-1.3.1
	sys-libs/pam
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/pixman
	gnutls? ( net-libs/gnutls:= )
	nls? ( virtual/libiconv )
	server? (
		x11-libs/libXau
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXfont2
		x11-libs/libXtst
		>=x11-libs/pixman-0.27.2
		>=x11-apps/xauth-1.0.3
		x11-apps/xsetroot
		>=x11-misc/xkeyboard-config-2.4.1-r3
		xorgmodule? ( =x11-base/xorg-server-${XSERVER_VERSION%.*}* )
		drm? ( x11-libs/libdrm )
		dev-libs/openssl:0=
	)
	xinerama? ( x11-libs/libXinerama )
	"

RDEPEND="${CDEPEND}
	!net-misc/tightvnc
	!net-misc/vnc
	!net-misc/xf4vnc
	java? ( virtual/jre:1.8 )"

DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )
	java? ( virtual/jdk:1.8 )
	x11-base/xorg-proto
	media-libs/fontconfig
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXcursor
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXi
	server? (
		dev-libs/libbsd
		x11-libs/libxkbfile
		x11-libs/libxshmfence
		virtual/pkgconfig
		media-fonts/font-util
		x11-misc/util-macros
		>=x11-libs/xtrans-1.3.3
		opengl? ( >=media-libs/mesa-10.3.4-r1 )
	)"

PATCHES=(
	# Restore Java viewer
	"${FILESDIR}"/${PN}-1.11.0-install-java-viewer.patch
)

src_prepare() {
	if use server; then
		cp -r "${WORKDIR}"/xorg-server-${XSERVER_VERSION}/. unix/xserver || die
		eapply "${FILESDIR}"/${P}-xorg-1.21.patch
		eapply "${DISTDIR}"/${P}-xserver-21.patch
	fi

	cmake_src_prepare

	if use server; then
		cd unix/xserver || die
		eapply ../xserver${XSERVER_VERSION}.patch
		eautoreconf
		sed -i 's:\(present.h\):../present/\1:' os/utils.c || die
		sed -i '/strcmp.*-fakescreenfps/,/^        \}/d' os/utils.c || die
	fi
}

src_configure() {
	if use arm || use hppa; then
		append-flags "-fPIC"
	fi

	local mycmakeargs=(
		-DENABLE_GNUTLS=$(usex gnutls)
		-DENABLE_NLS=$(usex nls)
		-DBUILD_JAVA=$(usex java)
	)

	cmake_src_configure

	if use server; then
		cd unix/xserver || die
		econf \
			$(use_enable opengl glx) \
			$(use_enable drm libdrm) \
			--disable-config-hal \
			--disable-config-udev \
			--disable-devel-docs \
			--disable-dri \
			$(use_enable dri3) \
			--disable-glamor \
			--disable-kdrive \
			--disable-libunwind \
			--disable-linux-acpi \
			--disable-record \
			--disable-selective-werror \
			--disable-static \
			--disable-unit-tests \
			--disable-xephyr \
			$(use_enable xinerama) \
			--disable-xnest \
			--disable-xorg \
			--disable-xvfb \
			--disable-xwin \
			--enable-dri2 \
			--with-pic \
			--without-dtrace \
			--disable-present \
			--with-sha1=libcrypto
	fi
}

src_compile() {
	cmake_src_compile

	if use server; then
		# deps of the vnc module and the module itself
		local d subdirs=(
			fb xfixes Xext dbe $(usex opengl glx "") $(usev dri3) randr render
			damageext miext Xi xkb composite dix mi os hw/vnc
		)
		for d in "${subdirs[@]}"; do
			emake -C unix/xserver/"${d}"
		done
	fi
}

src_install() {
	cmake_src_install

	if use server; then
		emake -C unix/xserver/hw/vnc DESTDIR="${D}" install
		if ! use xorgmodule; then
			rm -rv "${ED}"/usr/$(get_libdir)/xorg || die
		else
			rm -v "${ED}"/usr/$(get_libdir)/xorg/modules/extensions/libvnc.la || die
		fi

		newconfd "${FILESDIR}"/${PN}.confd ${PN}
		newinitd "${FILESDIR}"/${PN}.initd ${PN}

		systemd_douserunit unix/vncserver/vncserver@.service
	else
		local f
		for f in x0vncserver vncconfig; do
			rm "${ED}"/usr/bin/${f} || die
			rm "${ED}"/usr/share/man/man1/${f}.1 || die
		done
		rm -r "${ED}"/usr/{sbin,libexec} || die
		rm -r "${ED}"/usr/share/man/man8 || die
	fi
}
