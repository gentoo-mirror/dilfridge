# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=NEELY
MODULE_VERSION=0.60
inherit perl-module

DESCRIPTION="Modules that serialize data structures"
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"

RDEPEND="
	virtual/perl-AutoLoader
	virtual/perl-Data-Dumper
	virtual/perl-Digest-SHA
	virtual/perl-Exporter
"
DEPEND="${RDEPEND}
	virtual/perl-File-Spec
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )
"
