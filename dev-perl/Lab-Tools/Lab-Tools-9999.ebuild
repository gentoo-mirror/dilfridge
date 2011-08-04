# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://gitorious.org/lab-measurement/lab.git"
EGIT_BRANCH="connections"
EGIT_SOURCEDIR=${S}
inherit perl-module git-2

DESCRIPTION="High-level measurement tools for the Lab::Measurement module stack"
HOMEPAGE="http://www.labmeasurement.de/"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-lang/perl
	virtual/perl-Time-HiRes
	dev-perl/XML-Generator
	dev-perl/XML-DOM
	dev-perl/XML-Twig
	dev-perl/encoding-warnings
	sci-visualization/gnuplot"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
"

S=${WORKDIR}/${P}/Tools
