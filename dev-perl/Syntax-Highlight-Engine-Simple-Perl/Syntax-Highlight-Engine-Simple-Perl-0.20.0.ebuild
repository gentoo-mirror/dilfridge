# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPI-PowerToys/PPI-PowerToys-0.140.0.ebuild,v 1.1 2014/10/19 21:35:03 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=JAMADAM
MODULE_VERSION=0.02

inherit perl-module

DESCRIPTION="Experimental Perl code highlighting class"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Syntax-Highlight-Engine-Simple-0.08
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"
