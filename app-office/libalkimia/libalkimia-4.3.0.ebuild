# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base

DESCRIPTION="Library with common classes and functionality used by finance applications for the KDE SC"
HOMEPAGE="http://kde-apps.org/content/show.php/libalkimia?content=137323"
SRC_URI="http://kde-apps.org/CONTENT/content-files/137323-${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT=0
IUSE="doc"

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/${PN}-4.3.0-doc.patch" )

src_configure() {
	mycmakeargs=( $(cmake-utils_use_build doc) )
	kde4-base_src_configure
}
