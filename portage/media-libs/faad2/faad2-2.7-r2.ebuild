# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.7-r2.ebuild,v 1.9 2010/10/26 09:09:49 jer Exp $

EAPI=3
inherit autotools eutils

DESCRIPTION="AAC audio decoding library"
HOMEPAGE="http://www.audiocoding.com/faad2.html"
SRC_URI="mirror://sourceforge/faac/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="digitalradio static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libmp4ff-shared-lib.patch \
		"${FILESDIR}"/${P}-libmp4ff-install-mp4ff_int_types_h.patch \
		"${FILESDIR}"/${P}-man1_MANS.patch \
		"${FILESDIR}"/faad-audio.c.patch

	sed -i -e 's:iquote :I:' libfaad/Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking \
		$(use_with digitalradio drm) \
		--without-xmms
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README.linux TODO
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
