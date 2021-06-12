# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GITHUB_USER="trezor"
PYTHON_COMPAT=( python3_{6,7,8,9} )
KEYWORDS="~amd64 ~x86"

inherit github-pkg distutils-r1

DESCRIPTION="Python bindings to the hidapi library"

if [[ ${PV} != "9999" ]]; then
	MY_PV="${PV/_p/.post}"
	SRC_URI="${GITHUB_HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="|| ( GPL-3 BSD )"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/cython
	dev-libs/hidapi"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

python_configure_all() {
	mydistutilsargs=( --with-system-hidapi )
}
