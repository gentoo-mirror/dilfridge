# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="AKHUETTEL"
KEYWORDS="~amd64 ~x86"
inherit perl-module

DESCRIPTION="Documentation formatting for Lab::Measurement"
HOMEPAGE="http://www.labmeasurement.de/"

SLOT="0"

RDEPEND="
	virtual/perl-Data-Dumper
	virtual/perl-File-Path
	dev-perl/Pod-LaTeX
	virtual/perl-Pod-Simple
	dev-perl/Syntax-Highlight-Engine-Simple-Perl
	dev-perl/YAML
"
DEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
