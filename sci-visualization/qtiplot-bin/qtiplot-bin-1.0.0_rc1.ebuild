# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Qt based clone of the Origin plotting package, commercial binary"
HOMEPAGE="http://www.qtiplot.com/"
SRC_URI="020518_qtiplot-1.0.0-rc1-32bit-static.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch mirror splitdebug"
IUSE=""

QA_PREBUILT="*"

S=${WORKDIR}

RDEPEND="
	dev-libs/glib[abi_x86_32(-)]
	media-libs/fontconfig[abi_x86_32(-)]
	media-libs/freetype[abi_x86_32(-)]
	media-libs/mesa[abi_x86_32(-)]
	virtual/glu[abi_x86_32(-)]
	x11-libs/libICE[abi_x86_32(-)]
	x11-libs/libSM[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	x11-libs/libXrender[abi_x86_32(-)]
	!sci-visualization/qtiplot
"

src_install() {
	dodir /opt
	cp -av "${S}"/qtiplot-* "${D}/opt/qtiplot" || die

	dosym ../qtiplot/qtiplot /opt/bin/qtiplot
}
