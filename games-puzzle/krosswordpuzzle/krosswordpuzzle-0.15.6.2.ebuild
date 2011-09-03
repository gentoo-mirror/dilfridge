# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/bkodama/bkodama-0.3.1.ebuild,v 1.2 2011/01/31 02:56:06 tampakrap Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Crossword playing game and editor for KDE 4"
HOMEPAGE="http://kde-apps.org/content/show.php/KrossWordPuzzle?content=111726"
SRC_URI="http://kde-apps.org/CONTENT/content-files/111726-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/${PN}
