# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=ARODLAND
DIST_VERSION=1.04
inherit perl-module

DESCRIPTION="Keyed Hashing for Message Authentication"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"

RDEPEND="
	>=virtual/perl-Digest-MD5-2.0.0
	>=virtual/perl-Digest-SHA-1.0.0
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
