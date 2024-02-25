# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg-utils

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-wrapper.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-wrapper/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK3-based wrapper to display data to layer-shell window"
HOMEPAGE="https://github.com/nwg-piotr/nwg-wrapper"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	gui-libs/gtk-layer-shell
	x11-libs/gtk+:3
	dev-python/pygobject[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
