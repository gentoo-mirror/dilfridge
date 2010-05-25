# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit perl-module

S=${WORKDIR}/Net-Trackback-1.01

DESCRIPTION="No description available"
HOMEPAGE="http://search.cpan.org/search?query=Net-Trackback&mode=dist"
SRC_URI="mirror://cpan/authors/id/T/TI/TIMA/Net-Trackback-1.01.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64"

DEPEND=">=dev-perl/libwww-perl-5.831
	>=dev-perl/Class-ErrorHandler-0.01
	dev-lang/perl"
RDEPEND="$DEPEND"
