# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit autotools

DESCRIPTION="Drop-in replacement for cdialog using GTK"
HOMEPAGE=""

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WdesktopX/Xdialog.git"
else
	SRC_URI="https://github.com/WdesktopX/Xdialog/releases/download/v${PV}/Xdialog-${PV}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
	S="${WORKDIR}/${P/x/X}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc examples"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/gtk+-3.3.0:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"


DOCS=( AUTHORS BUGS ChangeLog README )

# PATCHES=( "${FILESDIR}"/${P}-install.patch )

src_prepare() {
	default
#	eautoreconf
}

src_configure() {
	econf \
		--enable-gtk3
}

src_install() {
	default

	rm -r "${D}"/usr/share/doc || die
	use doc && local HTML_DOCS=( doc/. )
	einstalldocs

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins samples/*
	fi
}
