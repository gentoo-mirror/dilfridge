# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit python

MY_PN="Impressive"

DESCRIPTION="Stylish way of giving presentations with Python"
HOMEPAGE="http://impressive.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}/${PV}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygame
	dev-python/pyopengl
	dev-python/imaging
	|| ( app-text/xpdf app-text/ghostscript-gpl )
	app-text/pdftk
	x11-misc/xdg-utils"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	dobin impressive.py || die
	doman impressive.1 || die
	dodoc changelog.txt demo.pdf || die
}
