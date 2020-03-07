# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" != "9999" ]]; then
	DIST_VERSION=9999 # change this
	DIST_AUTHOR=AKHUETTEL
	KEYWORDS="~amd64"
	inherit perl-module
else
	EGIT_REPO_URI="https://github.com/lab-measurement/Lab-VISA.git"
	inherit perl-module git-r3
fi

DESCRIPTION="Perl interface to National Instrument's VISA library"
HOMEPAGE="http://www.labvisa.de/"

SLOT="0"
IUSE=""

DEPEND="sci-libs/ni-visa"
RDEPEND="${DEPEND}"
