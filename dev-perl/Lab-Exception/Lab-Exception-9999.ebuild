# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module git-2

DESCRIPTION="Exception handling for the Lab::Measurement module stack"
HOMEPAGE="http://www.labmeasurement.de/"
EGIT_REPO_URI="git://gitorious.org/lab-measurement/lab.git"
EGIT_BRANCH="connections"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-lang/perl
	dev-perl/Exception-Class
"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
"

src_unpack() {
	git-2_src_unpack
	S=${WORKDIR}/${P}/Exception
}
