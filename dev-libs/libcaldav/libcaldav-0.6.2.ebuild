# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base

DESCRIPTION="C library implementing client support for CalDAV"
HOMEPAGE="http://libcaldav.sourceforge.net/"
SRC_URI="mirror://sourceforge/libcaldav/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-libs/glib
	net-misc/curl
"
DEPEND="${RDEPEND}
	doc? ( 	app-doc/doxygen
		virtual/latex-base )
"

src_configure() {
	econf $(use_enable doc) || die
}
