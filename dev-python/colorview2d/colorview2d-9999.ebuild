# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rarfile/rarfile-2.6.ebuild,v 1.2 2013/09/05 18:47:11 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 git-r3

DESCRIPTION="Plotting and stuff"
HOMEPAGE="https://gitorious.org/colorview2d/colorview2d/"
# SRC_URI="mirror://pypi/r/${PN}/${P}.tar.gz"
EGIT_REPO_URI="git://gitorious.org/colorview2d/akhuettels-colorview2d.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/wxpython[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/${PN}
