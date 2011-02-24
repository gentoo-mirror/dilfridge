# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit base autotools eutils toolchain-funcs

DESCRIPTION="MoM 2.5 D stripline simulator"
SRC_URI="mirror://sourceforge/mmtl/${P}.tar.gz"
HOMEPAGE="http://mmtl.sourceforge.net/"
LICENSE="BSD GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

SLOT="0"
IUSE="doc"

RDEPEND="
	dev-lang/tcl
	dev-tcltk/tcllib
	dev-tcltk/itcl
	dev-tcltk/bwidget
	sys-devel/gcc[fortran]
"
DEPEND="${RDEPEND}
	dev-texlive/texlive-latex
	dev-tex/latex2html
	media-gfx/imagemagick
"

src_prepare() {
	# Adapt this old source to the new C++ standards
	# These patches fix a c++ scope issue, gcc was for some reason
	# not able to discover friend function of class Complex.
	# This has been solved by making this functions a member instead of a friend.
	epatch "${FILESDIR}/${P}"-calc-cap-calcCAP.patch
	epatch "${FILESDIR}/${P}"-calc-cap-cmplxmat.patch
	epatch "${FILESDIR}/${P}"-calc-cap-cmplxvec.patch
	epatch "${FILESDIR}/${P}"-calc-cap-complex-header.patch
	epatch "${FILESDIR}/${P}"-calc-cap-complex-source.patch
	epatch "${FILESDIR}/${P}"-calc-cap-data.patch
	epatch "${FILESDIR}/${P}"-calc-rl-calcRL.patch
	epatch "${FILESDIR}/${P}"-calc-rl-cmplxmat.patch
	epatch "${FILESDIR}/${P}"-calc-rl-cmplxvec.patch
	epatch "${FILESDIR}/${P}"-calc-rl-complex-header.patch
	epatch "${FILESDIR}/${P}"-calc-rl-complex.patch
	epatch "${FILESDIR}/${P}"-calc-rl-data.patch
	epatch "${FILESDIR}/${P}"-calc-rl-kelvin.patch
	epatch "${FILESDIR}/${P}"-calc-rl-hankel.patch
	#fix a minor code error
	epatch "${FILESDIR}/${P}"-bem-nmmtl.patch
	# Update headers in remaining files
	# The source code is from the pre-namespace era.
	sed -i 's/<iostream.h>/\<iostream\>\nusing\ namespace\ std\;/' `grep -r -l iostream.h *`
	sed -i 's/<iomanip.h>/\<iomanip\>\nusing\ namespace\ std\;/' `grep -r -l iomanip.h *`
	sed -i 's/<fstream.h>/\<fstream\>\nusing\ namespace\ std\;/' `grep -r -l fstream.h *`
	# Update fortran compiler
	sed -i 's/\"g77\"/\"$(tc-getF77)\"/' bem/configure.ac
	sed -i 's/\"g77\"/\"$(tc-getF77)\"/' calcCAP/configure.ac
	sed -i 's/\"g77\"/\"$(tc-getF77)\"/' calcRL/configure.ac
	#block document installation
	epatch "${FILESDIR}/${P}"-Makefile-am.patch
	epatch "${FILESDIR}/${P}"-doc-Makefile-am.patch
	epatch "${FILESDIR}/${P}"-tkcon.patch
	#adjust new document location in gui
	epatch "${FILESDIR}/${P}"-gui-splash.patch
	sed -i "s/package_name/${PF}/" gui/splash.tcl
	epatch "${FILESDIR}/${P}"-gui_help.patch
	sed -i "s/package_name/${PF}/" gui/gui_help.tcl
	# regenerate the configure and make files
	rm aclocal.m4
	eautoreconf --force
}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS || die "failed to install docs"
	dohtml COPYING #tcl cannot handle the archives created by dodoc
	if use doc; then
				dodoc doc/*.pdf doc/*.png
				dohtml doc/user-guide/*
	fi
	#Install icon
	convert gui/logo.gif gui/tnt.png
	docinto "examples"
	dodoc examples/* || die "failed to install exampels"
	newicon gui/tnt.png tnt.png
	make_desktop_entry ${PN} "Mttl" ${PN}
}

pkg_postinst() {
		einfo "Warning: the sources are not under development anymore."
		einfo "We made it compile, but users should check if the results make sense."
		einfo "The GUI was written in an old version of TCL/TK."
		einfo "Examples are in the /usr/share/doc/tnt-1.2.2 folder."
}
