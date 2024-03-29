# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=GIRAFFED
DIST_VERSION=1.38
DIST_EXAMPLES=("demo" "demo2" "demo.form" "demo.menu" "demo.panel")
inherit perl-module

DESCRIPTION="Curses interface modules for Perl"

SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ppc64 ~s390 sparc x86 ~sparc-solaris"
IUSE="+unicode"

RDEPEND="
	sys-libs/ncurses:=[unicode(+)?]
	virtual/perl-Data-Dumper
"
DEPEND="
	sys-libs/ncurses:=[unicode(+)?]
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

src_configure() {
	myconf="${myconf} FORMS PANELS MENUS"
	mydoc=HISTORY
	export CURSES_LIBTYPE="$(usex unicode ncursesw ncurses)"
	local nc_tool="${CURSES_LIBTYPE}$(has_version 'sys-libs/ncurses:0/6' && echo 6 || echo 5)-config"
	export CURSES_LDFLAGS=$( ${nc_tool} --libs )
	export CURSES_CFLAGS=$( ${nc_tool} --cflags )
	perl-module_src_configure
	if ! use unicode ; then
		sed -i 's:<form.h>:"/usr/include/form.h":' "${S}"/c-config.h || die
	fi
}
