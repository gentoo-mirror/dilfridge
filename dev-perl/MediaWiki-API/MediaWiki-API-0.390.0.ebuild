# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lab-Measurement/Lab-Measurement-3.200.0.ebuild,v 1.1 2013/10/19 18:31:56 dilfridge Exp $

EAPI=5

MODULE_AUTHOR="EXOBUZZ"
MODULE_VERSION="0.39"
inherit perl-module

DESCRIPTION="A OO interface to the Mediawiki API"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/JSON
	dev-perl/libwww-perl
	virtual/perl-Encode
	virtual/perl-Test-Simple
"
