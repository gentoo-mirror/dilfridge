# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Collection of useful math-related functions"
HOMEPAGE="http://search.cpan.org/~sifukurt/"
SRC_URI="mirror://cpan/authors/id/S/SI/SIFUKURT/${P}.tar.gz"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND=${DEPEND}
