# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sleepyhead/sleepyhead-0.9.3.ebuild,v 1.3 2014/08/10 18:08:51 slyfox Exp $

EAPI=5
inherit multilib qt4-r2
DESCRIPTION="Library written in C++ for Qt that implements the OAuth 1.0 authentication specification"
HOMEPAGE="http://www.johanpaul.com/blog/kqoauth/"

SRC_URI="https://github.com/kypeli/kQOAuth/tarball/${PV} -> ${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS=""

IUSE=""

DEPEND="dev-qt/qtcore:4"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	mv -v "${WORKDIR}"/kypeli-kQOAuth-* "${WORKDIR}/kypeli-kQOAuth" || die
	S="${WORKDIR}/kypeli-kQOAuth"
}
