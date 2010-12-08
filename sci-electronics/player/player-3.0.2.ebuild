# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils python cmake-utils

DESCRIPTION="A network server for robot control"
HOMEPAGE="http://playerstage.sourceforge.net/index.php?src=player"
SRC_URI="mirror://sourceforge/playerstage/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PLAYER_DRIVERS_TESTED="none"

IUSE="ieee1394 sphinx2 wifi v4l test
	boost gnome gtk openssl festival
	opengl glut gsl java python doc"

for driver in ${PLAYER_DRIVERS_TESTED}; do
        IUSE="${IUSE} player_drivers_${driver}"
done
unset driver

RDEPEND="media-libs/jpeg
	opengl? ( virtual/opengl )
	glut? ( media-libs/freeglut )
	openssl? ( dev-libs/openssl )
	imagemagick? ( media-gfx/imagemagick )
	gsl? ( sci-libs/gsl )
	ieee1394? ( sys-libs/libraw1394 media-libs/libdc1394 )
	java? ( virtual/jdk )
	gtk? ( x11-libs/gtk+ )
	gnome? ( >=gnome-base/libgnomecanvas-2.0 )
	boost? ( dev-libs/boost )
	sphinx2? ( app-accessibility/sphinx2 )
	festival? ( app-accessibility/festival )"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	java? ( dev-lang/swig )
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/${P}"-docs.patch )

pkg_setup () {
	python_set_active_version 2
}


src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build doc DOCUMENTATION)
	)

	cmake-utils_src_configure
}


