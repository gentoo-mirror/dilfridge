# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A C library to generate ICMP echo requests and ncurses based utility to ping multiple hosts at once"
HOMEPAGE="http://verplant.org/liboping"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl sys-devel/libperl  )"
RDEPEND="${DEPEND} sys-libs/ncurses"

src_configure() {
	if use !perl ; then
		 myconf="${myconf} --without-perl-bindings"	
	fi

	econf ${myconf} --prefix=/usr --disable-static || die "Configure failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"
	find "${D}" -name '*.la'  -delete
}

