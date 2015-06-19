# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/natbib/natbib-8.31a-r1.ebuild,v 1.1 2010/10/02 17:31:15 dilfridge Exp $

EAPI=3

inherit latex-package

DESCRIPTION="LaTeX package to use the basic Windows truetype fonts"

SRC_URI="http://mirror.ctan.org/fonts/${PN}/${PN}.zip -> ${P}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/fonts/winfonts/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND="media-fonts/corefonts"

S=${WORKDIR}

TEXMF=/usr/share/texmf-site

src_unpack() {
	unzip -o -j "${DISTDIR}/${A}" || die
}

src_install() {
	insinto ${TEXMF}/fonts/map/pdftex
	doins *.map || die

	insinto /etc/texmf/updmap.d
	doins "${FILESDIR}/winfonts.cfg" || die

	dosym /usr/share/fonts/corefonts "${TEXMF}/fonts/truetype/corefonts" || die

	latex-package_src_install
}
