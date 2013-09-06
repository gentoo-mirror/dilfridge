# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencv/opencv-2.4.6.1.ebuild,v 1.1 2013/09/04 18:43:16 dilfridge Exp $

EAPI=5

inherit cmake-utils

MY_PN=OpenTLD

DESCRIPTION="Library for tracking objects in video streams"
HOMEPAGE="http://gnebehay.github.io/OpenTLD/"
SRC_URI="https://github.com/gnebehay/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt4"

RDEPEND="
	dev-libs/libconfig[cxx]
	media-libs/opencv
	qt4? ( dev-qt/qtcore dev-qt/qtgui )
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}

PATCHES=( "${FILESDIR}/${P}"-shared.patch )

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBS=ON
		$(cmake-utils_use_build qt4 QOPENTLD)
	)

	cmake-utils_src_configure
}
