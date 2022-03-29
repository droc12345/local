# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson xdg-utils

DESCRIPTION="Small utility for fast and easy GUI building"
HOMEPAGE="https://github.com/puppylinux-woof-CE/gtkdialog"
EGIT_REPO_URI="https://github.com/puppylinux-woof-CE/gtkdialog"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="vte docs"

RDEPEND="
	gui-libs/gtk-layer-shell
	x11-libs/gtk+:3
	vte? ( x11-libs/vte:2.91= )
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		"-Ddocs=$(usex docs true false)"
		"-Dvte=$(usex vte true false)"
		--wrap-mode=default
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if use docs; then
		cp -pPR examples/ "${D}"/usr/share/doc/${P}/
		cp -pPR doc/reference/ "${D}"/usr/share/doc/${P}/
	fi
	# Stop make install from running gtk-update-icon-cache
#	emake DESTDIR="${D}" UPDATE_ICON_CACHE=true install
#	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
