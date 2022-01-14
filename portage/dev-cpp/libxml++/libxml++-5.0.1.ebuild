# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="5.0"

SRC_URI="https://download.gnome.org/sources/libxml++/${SLOT}/libxml++-${PV}.tar.xz"

KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND="
	>=dev-libs/libxml2-2.7.7
	>=dev-cpp/glibmm-2.32:2
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"
