# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=OALDERS
DIST_VERSION=6.10
inherit perl-module

DESCRIPTION="Provide https support for LWP::UserAgent"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-solaris"

RDEPEND="
	app-misc/ca-certificates
	>=dev-perl/IO-Socket-SSL-1.540.0
	>=dev-perl/libwww-perl-6.60.0
	>=dev-perl/Net-HTTP-6
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-RequiresInternet
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-6.70.0-etcsslcerts.patch
	"${FILESDIR}"/${PN}-6.70.0-CVE-2014-3230.patch # note: breaks a test, still needed?
)

PERL_RM_FILES=(
	"t/https_proxy.t" # see above
)
