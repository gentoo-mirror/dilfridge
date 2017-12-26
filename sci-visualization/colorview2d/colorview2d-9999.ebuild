# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Loisel/colorview2d.git"
else
	SRC_URI="mirror://pypi/r/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Plotting and stuff"
HOMEPAGE="https://loisel.github.io/colorview2d/"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]

"
RDEPEND="${DEPEND}"

# likely not needed anymore:
#	dev-python/wxpython:*[${PYTHON_USEDEP}]
#	sci-libs/scipy[${PYTHON_USEDEP}]
#	dev-python/lmfit[${PYTHON_USEDEP}]
#	dev-python/pydispatcher[${PYTHON_USEDEP}]
#	dev-python/yapsy[${PYTHON_USEDEP}]
