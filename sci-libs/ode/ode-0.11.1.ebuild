# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="High performance library for simulating rigid body dynamics"
HOMEPAGE="http://www.ode.org/"
SRC_URI="mirror://sourceforge/project/opende/ODE/${PV}/${P}.tar.bz2"
# http://downloads.sourceforge.net/project/opende/ODE/0.11.1/ode-0.11.1.zip

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	econf --enable-double-precision --enable-shared || die
}

src_install(){
	default
	rm "${DESTDIR}/usr/lib64/libode.la" || die
}
