# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sleepyhead/sleepyhead-0.9.3.ebuild,v 1.3 2014/08/10 18:08:51 slyfox Exp $

EAPI=5
inherit cmake-utils
DESCRIPTION="Qt library for basic web service support with version 1.1 of the SOAP protocol"
HOMEPAGE="https://github.com/commontk/QtSOAP"

MY_PN=QtSOAP

SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${MY_PN}-${PV}.tar.xz"
LICENSE="BSD"
SLOT="0"

KEYWORDS=""

IUSE=""

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
