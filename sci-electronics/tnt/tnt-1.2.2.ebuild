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

PATCHES=( "${FILESDIR}/${P}"-{calc,bem-nmmtl,namespaces}.patch )

src_prepare() {
	base_src_prepare

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
