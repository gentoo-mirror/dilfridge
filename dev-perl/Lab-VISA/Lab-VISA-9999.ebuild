# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module subversion

DESCRIPTION="Perl interface to National Instrument's VISA library"
HOMEPAGE="http://www.labvisa.de/"
ESVN_REPO_URI="https://vcs.uni-regensburg.de/svn/group/weiss/Software/trunk/Lab/VISA"
ESVN_USER="anon"
ESVN_PASSWORD="anon"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/perl sci-libs/ni-visa"
RDEPEND="${DEPEND}"
