# Copyright 2012 Raffaello D. Di Napoli
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils multilib scons-utils toolchain-funcs

DESCRIPTION="A Gtk+-based joystick testing and configuration tool for Linux"
HOMEPAGE="http://pingus.seul.org/~grumbel/${PN}/"
SRC_URI="http://pingus.seul.org/~grumbel/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-cpp/gtkglextmm:1.0
	dev-libs/libsigc++:2
"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
	epatch "${FILESDIR}/${P}-define-uint8_t.patch"

	# Build an environment to match our own.
	local envdict="PKG_CONFIG=\"$(tc-getPKG_CONFIG)\""
	envdict="${envdict}, CXX=\"$(tc-getCXX)\""
	envdict="${envdict}, CXXFLAGS=\"${CXXFLAGS}\""
	envdict="${envdict}, LINK=\"$(tc-getCXX)\""
	envdict="${envdict}, LINKFLAGS=\"${LDFLAGS}\""
	# Replace the minimalistic environment with our own.
	sed -i -e 's/CXXFLAGS=\[[^]]\+]/'"${envdict}"'/' SConstruct
}

src_compile() {
	escons
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
}
