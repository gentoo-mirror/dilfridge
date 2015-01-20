# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rarfile/rarfile-2.6.ebuild,v 1.2 2013/09/05 18:47:11 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 git-r3

DESCRIPTION="Plotting and stuff"
HOMEPAGE="https://gitorious.org/colorview2d/colorview2d/"
# SRC_URI="mirror://pypi/r/${PN}/${P}.tar.gz"
EGIT_REPO_URI="git://git.code.sf.net/p/colorview2d/code"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/wxpython[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
