# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-1.6.0.ebuild,v 1.1 2010/11/25 20:30:29 dilfridge Exp $

EAPI=3

DIGIKAMPN=digikam
DIGIKAMPV=2.0.0_beta1

KDE_LINGUAS=""
#KDE_LINGUAS="be ca ca@valencia de el en_GB eo es et eu fi fr he hi hne hu is it km
#	ko lt lv nds nn pa pl pt pt_BR ro se sl sv th tr vi zh_CN zh_TW"

CMAKE_MIN_VERSION=2.8

KDE_OVERRIDE_MINIMAL="4.5.0"

inherit kde4-base

MY_P="${DIGIKAMPN}-${DIGIKAMPV/_/-}"

DESCRIPTION="Wrapper library for world map components as marble, openstreetmap and googlemap"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="doc semantic-desktop"

CDEPEND="
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep marble plasma)
	x11-libs/qt-gui[qt3support]
	|| ( x11-libs/qt-sql[mysql] x11-libs/qt-sql[sqlite] )
"
RDEPEND="${CDEPEND}
	$(add_kdebase_dep kreadconfig)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}/extra/${PN}"

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
		$(cmake-utils_use_with geolocation MarbleWidget)
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

	if use handbook; then
		dodoc readme-handbook.txt || die
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use doc; then
		elog The ${P} api documentation has been installed at /usr/share/doc/${PF}/html
	fi
}