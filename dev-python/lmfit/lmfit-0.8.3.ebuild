# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Non-Linear Least-Square Minimization and Curve-Fitting"
HOMEPAGE="http://cars9.uchicago.edu/software/python/lmfit/"
SRC_URI="mirror://pypi/l/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
