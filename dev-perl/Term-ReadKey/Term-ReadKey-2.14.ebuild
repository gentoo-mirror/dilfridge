# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit perl-module

MY_PN="TermReadKey"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="No description available"
HOMEPAGE="http://search.cpan.org/~kjalb/TermReadKey-2.14/"
SRC_URI="mirror://cpan/authors/id/K/KJ/KJALB/${MY_PN}-${PV}.tar.gz"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"
RDEPEND="$DEPEND"
