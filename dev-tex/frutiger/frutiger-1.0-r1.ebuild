# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit latex-package

MY_P="FrutigerNext-PostScriptType1"

DESCRIPTION="LaTeX2e macros for the Uni Regensburg Corporate Design"
HOMEPAGE="http://www.physik.uni-regensburg.de/service/"

SRC_URI="http://www.uni-regensburg.de/verwaltung/medien/corporate-design/frutiger-la-tex.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="app-arch/unzip"

IUSE=""

S="${WORKDIR}/${MY_P}"

RESTRICT="bindist mirror primaryuri"

src_unpack() {
	default
	cd "${S}" || die

	# flatten the directory structure
	mv -v afm/* . || die
	rmdir afm || die
	mv -v pfb/* . || die
	rmdir pfb || die

	unzip -o -j lf9.zip || die
	rm -f "UR_Anleitung zur Installation der Hausschrift unter LaTeX.pdf" || die
}

src_install() {
	latex-package_src_install

	rm -f manual/lf9.zip || die
	dohtml -r manual/*
}
