# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package versionator

DESCRIPTION="LaTeX package for drawing chemical structures"
HOMEPAGE="http://xymtex.com/"
MY_PV="$(delete_all_version_separators)"
SRC_URI="http://xymtex.com/fujitas3/xymtex/xym406/xym-up/xymtex${MY_PV}.zip"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-arch/unzip"
S="${WORKDIR}/${PN}"
src_install() {
	latex-package_src_install || die
	cd ${S}/doc*${MY_PV}*
	latex-package_src_doinstall pdf
}
