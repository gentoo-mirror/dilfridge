# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Modules that serialize data structures"
HOMEPAGE="http://search.cpan.org/~neely/"
SRC_URI="mirrors://cpan/authors/id/N/NE/NEELY/${P}.tar.gz"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl perl-core/File-Spec perl-core/Digest-SHA"
RDEPEND=${DEPEND}
