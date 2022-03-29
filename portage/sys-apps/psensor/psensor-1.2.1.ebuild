# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="A graphical hardware temperature monitor"
HOMEPAGE="http://wpitchoune.net/psensor"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/jeanfi/psensor.git"
	KEYWORDS=""
else
	SRC_URI="http://wpitchoune.net/${PN}/files/${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi
LICENSE="GPL-2"
SLOT="0"

IUSE="doc gnome gtop +hddtemp notify server udisks"

RDEPEND="
	sys-apps/lm-sensors
	gtop? ( gnome-base/libgtop:2 )
	hddtemp? ( app-admin/hddtemp )
	dev-libs/glib:2
	dev-libs/libatasmart
	gnome? ( gnome-base/dconf )
	notify? ( 
		dev-libs/libappindicator
		x11-libs/libnotify
	)
	server? ( 
		dev-libs/json-c
		net-libs/libmicrohttpd
	)	
	udisks? ( sys-fs/udisks:2 )
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXext"

DEPEND="${RDEPEND}
	doc? (
		sys-apps/help2man
		app-text/asciidoc
	)"

src_configure() {
	local econfargs=(
		$(use_with gtop) 
		$(use_with gnome gsettings) 
	)

	econf "${econfargs[@]}" || die
}
