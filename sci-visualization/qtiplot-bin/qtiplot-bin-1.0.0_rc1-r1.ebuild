# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Qt based clone of the Origin plotting package, commercial binary"
HOMEPAGE="http://www.qtiplot.com/"
SRC_URI="020518_qtiplot-1.0.0-rc1-64bit-static.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="fetch mirror splitdebug"
IUSE=""

QA_PREBUILT="*"

S=${WORKDIR}

RDEPEND="
	=dev-db/sqlite-2*
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa
	virtual/glu
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	!sci-visualization/qtiplot
"

src_install() {
	dodir /opt
	cp -av "${S}"/qtiplot-* "${D}/opt/qtiplot" || die

	dosym ../qtiplot/qtiplot /opt/bin/qtiplot
}
