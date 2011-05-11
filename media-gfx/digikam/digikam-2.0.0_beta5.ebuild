# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-1.6.0.ebuild,v 1.1 2010/11/25 20:30:29 dilfridge Exp $

EAPI=4

if [ "${PV}" != "9999" ]; then
	KDE_LINGUAS=""
#	KDE_LINGUAS="be ca ca@valencia de el en_GB eo es et eu fi fr he hi hne hu is it km
#		ko lt lv nds nn pa pl pt pt_BR ro se sl sv th tr vi zh_CN zh_TW"
else
	KMNAME="extragear/graphics"
fi

CMAKE_MIN_VERSION=2.8

KDE_MINIMAL="4.6"
KDEGRAPHICS_MINIMAL="4.6.29"

inherit kde4-base

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="addressbook debug doc gphoto2 handbook semantic-desktop themedesigner +thumbnails video"

CDEPEND="
	$(add_kdebase_dep kdelibs semantic-desktop)
	$(add_kdebase_dep marble plasma)
	$(add_kdebase_dep libkipi)
	$(add_kdebase_dep libkexiv2)
	>=kde-base/libkdcraw-${KDEGRAPHICS_MINIMAL}
	>=media-libs/libkface-${PV}
	>=media-libs/libkmap-${PV}
	$(add_kdebase_dep solid)
	media-libs/jasper
	virtual/jpeg
	media-libs/lcms:0
	>=media-libs/lensfun-0.2.5
	media-libs/liblqr
	media-libs/libpng
	media-libs/tiff
	media-libs/libpgf
	>=media-plugins/kipi-plugins-1.2.0-r1
	|| ( >=sci-libs/clapack-3.2.1-r3 sci-libs/lapack-atlas )
	virtual/mysql
	x11-libs/qt-gui[qt3support]
	|| ( x11-libs/qt-sql[mysql] x11-libs/qt-sql[sqlite] )
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	gphoto2? ( media-libs/libgphoto2 )
"
RDEPEND="${CDEPEND}
	>=kde-base/kreadconfig-${KDE_MINIMAL}
	video? (
		|| (
			>=kde-base/mplayerthumbs-${KDE_MINIMAL}
			>=kde-base/ffmpegthumbs-${KDE_MINIMAL}
		)
	)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )
"

PATCHES=( "${FILESDIR}/${PN}"-2.0.0_beta5-docs.patch )

S="${WORKDIR}/${MY_P}/core"

src_prepare() {
	# just to make absolutely sure
	rm -rf "${WORKDIR}/${MY_P}/extra" || die

	mv "${WORKDIR}/${MY_P}/doc/${PN}" doc || die
	echo "add_subdirectory( digikam )" > doc/CMakeLists.txt
	echo "add_subdirectory( showfoto )" >> doc/CMakeLists.txt

	kde4-base_src_prepare

	if use handbook; then
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	fi
}

src_configure() {
	local backend

	use semantic-desktop && backend="Nepomuk" || backend="None"
	# LQR = only allows to choose between bundled/external
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
		-DWITH_LQR=ON
		-DWITH_LENSFUN=ON
		-DGWENVIEW_SEMANTICINFO_BACKEND=${backend}
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_build doc)
		-DWITH_MarbleWidget=ON
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with gphoto2)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable themedesigner)
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	if use doc; then
		# install the api documentation
		dodir /usr/share/doc/${PF}/html || die
		insinto /usr/share/doc/${PF}/html
		doins -r ${CMAKE_BUILD_DIR}/api/html/* || die
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use doc; then
		elog The digikam api documentation has been installed at /usr/share/doc/${PF}/html
	fi
}
