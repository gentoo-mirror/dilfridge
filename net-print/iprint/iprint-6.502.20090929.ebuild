# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DESCRIPTION="Micro Focus iPrint client"
HOMEPAGE="https://www.novell.com/products/openenterpriseserver/iprint.html"
SRC_URI="novell-iprint-xclient.x86_64.rpm"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="fetch mirror"

RDEPEND="
"
DEPEND="${RDEPEND}
"

S=${WORKDIR}

src_install() {
	mv -v "${WORKDIR}"/* "${D}/" || die

	mv -v "${D}/usr/lib" "${D}/usr/lib32" || die
	mv -v "${D}/opt/novell/lib" "${D}/opt/novell/lib32" || die
}
