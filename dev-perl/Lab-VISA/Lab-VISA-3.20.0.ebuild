# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_VERSION=3.02
DIST_AUTHOR=AKHUETTEL
KEYWORDS=""
inherit perl-module

DESCRIPTION="Perl interface to National Instrument's VISA library"
HOMEPAGE="http://www.labvisa.de/"

SLOT="0"
IUSE=""

DEPEND="sci-libs/ni-visa"
RDEPEND="${DEPEND}"
