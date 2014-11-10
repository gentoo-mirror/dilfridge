# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Qt based clone of the Origin plotting package, commercial binary"
HOMEPAGE="http://www.qtiplot.com/"
SRC_URI="180814_qtiplot-0.9.9-rc12-64bit-static.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="fetch mirror splitdebug"
IUSE=""

QA_PREBUILT="*"

S=${WORKDIR}

RDEPEND="
	dev-db/sqlite:0
	=dev-db/mysql-5.5*
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	virtual/glu
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libX11
	!sci-visualization/qtiplot
"

src_install() {
	dodir /opt
	cp -av "${S}"/qtiplot-* "${D}/opt/qtiplot" || die

	dodir /opt/qtiplot/lib
	dosym /usr/lib64/libmysqlclient_r.so.18 /opt/qtiplot/lib/libmysqlclient_r.so.16

	mv "${D}/opt/qtiplot/qtiplot" "${D}/opt/qtiplot/qtiplot.bin" || die

	dodir /opt/bin
	echo -e "#!/bin/bash\nLD_LIBRARY_PATH=/opt/qtiplot/lib /opt/qtiplot/qtiplot.bin" > "${D}/opt/bin/qtiplot" || die
	fperms +x /opt/bin/qtiplot
}
