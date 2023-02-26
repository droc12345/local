# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit meson python-any-r1

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/emersion/${PN}.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://gitlab.freedesktop.org/emersion/${PN}/-/releases/${PV}/downloads/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Used to get and parse edid display info"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="sys-apps/hwdata"
DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	test? ( >=sys-apps/edid-decode-0_pre20230131 )
"
