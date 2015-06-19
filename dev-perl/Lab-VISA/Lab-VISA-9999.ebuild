# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" != "9999" ]]; then
	MODULE_VERSION=9999 # change this
	MODULE_AUTHOR=AKHUETTEL
	KEYWORDS=""
	inherit perl-module
else
	EGIT_REPO_URI="https://github.com/lab-measurement/lab-measurement.git"
	EGIT_BRANCH="master"
	EGIT_SOURCEDIR=${S}
	KEYWORDS=""
	S=${WORKDIR}/${P}/VISA
	inherit perl-module git-2
fi

DESCRIPTION="Perl interface to National Instrument's VISA library"
HOMEPAGE="http://www.labvisa.de/"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
IUSE=""

DEPEND="sci-libs/ni-visa"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}
