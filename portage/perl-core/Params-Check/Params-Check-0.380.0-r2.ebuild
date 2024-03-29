# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=BINGOS
DIST_VERSION=0.38
inherit perl-module

DESCRIPTION="A generic input parsing/checking mechanism"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"

RDEPEND="virtual/perl-Locale-Maketext-Simple"
BDEPEND="${RDEPEND}"
