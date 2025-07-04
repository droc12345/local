# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Lightweight KMS plane library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libliftoff"

inherit git-r3
EGIT_REPO_URI="file:////n/don/git/libliftoff/"


#KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	x11-libs/libdrm
"
DEPEND="
	${RDEPEND}
"
