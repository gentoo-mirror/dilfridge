# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KMNAME="kdepim"
KDE_HANDBOOK=optional
VIRTUALX_REQUIRED=test
#inherit flag-o-matic kde4-meta
inherit flag-o-matic kde4-base

DESCRIPTION="Email component of Kontact (noakonadi branch)"
HOMEPAGE="https://launchpad.net/~pali/+archive/ubuntu/kdepim-noakonadi"
KEYWORDS=""
IUSE="debug"

EGIT_BRANCH=trim
EGIT_REPO_URI=http://github.com/akhuettel/kdepim-noakonadi.git

DEPEND="
	$(add_kdebase_dep kdelibs '' 4.13.1)
	$(add_kdeapps_dep kdepimlibs '' 4.13.1)
	app-crypt/gpgme
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
	!kde-apps/libkdepim:4
	!kde-apps/libkleo:4
	!kde-apps/libkpgp:4
	!kde-apps/kdepim-common-libs:4
	!>=kde-apps/kdepimlibs-4.14.11_pre20160211
"

KMEXTRA="
	kmailcvt/
	ksendemail/
	libkdepim/
	libkleo/
	libkpgp/
	libksieve/
	messagecore/
	messagelist/
	messageviewer/
	mimelib/
	plugins/kmail/
"

src_configure() {
	mycmakeargs=(
		-DWITH_IndicateQt=OFF
	)

	kde4-base_src_configure
}

src_compile() {
	kde4-base_src_compile kmail_xml
	kde4-base_src_compile
}
