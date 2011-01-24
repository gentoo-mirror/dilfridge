# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit latex-package

MY_P="FrutigerNext-PostScriptType1"

DESCRIPTION="LaTeX2e macros for the Uni Regensburg Corporate Design"
HOMEPAGE="http://www.physik.uni-regensburg.de/service/"

SRC_URI="FrutigerNextPro_LaTeX-1.0.zip"

LICENSE="internal-use-only"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"

IUSE=""

RESTRICT="fetch"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	cd "${S}"
	unzip -o lf9.zip
}

src_install() {



	latex-package_src_install
}
