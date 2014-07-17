# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit unpacker python-single-r1

DESCRIPTION="Qt based clone of the Origin plotting package, commercial binary"
HOMEPAGE="http://www.qtiplot.com/"
SRC_URI="290414_qtiplot_0.9.9-rc11_x86_64_ubuntu14_04.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror splitdebug"
IUSE=""

QA_PREBUILT="*"

S=${WORKDIR}

RDEPEND="
media-libs/glu
dev-libs/glib:2
media-video/ffmpeg
!sci-visualization/qtiplot
"

REQUIRED_USE=" ${PYTHON_REQUIRED_USE} "

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	cp -av "${S}"/* "${D}/"
}