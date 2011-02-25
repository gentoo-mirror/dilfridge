# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2html/latex2html-2008.ebuild,v 1.10 2010/06/12 12:31:43 aballier Exp $

EAPI=4

inherit base eutils multilib

DESCRIPTION="convertor written in Perl that converts LATEX documents to HTML"
SRC_URI="http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${P}.tar.gz
	http://dev.gentoo.org/~dilfridge/distfiles/${PN}-match-multiline.patch.bz2"
HOMEPAGE="http://www.latex2html.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gif png"

DEPEND="app-text/ghostscript-gpl
	virtual/latex-base
	media-libs/netpbm
	dev-lang/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}"-{convert-length,perl_name,extract-major-version,destdir}.patch 
	"${DISTDIR}/${PN}"-match-multiline.patch.bz2 )

src_prepare() {
	base_src_prepare

	# Dont install old url.sty and other files
	# Bug #240980
	rm -f texinputs/url.sty texinputs/latin9.def || die "failed to remove duplicate latex files"
}

src_configure() {
	local myconf

	use gif || use png || myconf="${myconf} --disable-images"

	econf --libdir=/usr/$(get_libdir)/latex2html \
		--shlibdir=/usr/$(get_libdir)/latex2html \
		--enable-pk \
		--enable-eps \
		--enable-reverse \
		--enable-pipes \
		--enable-paths \
		--enable-wrapper \
		--with-texpath=/usr/share/texmf-site/tex/latex/html \
		--without-mktexlsr \
		$(use_enable gif) \
		$(use_enable png) \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc BUGS Changes FAQ LICENSE.orig MANIFEST README* TODO

	# make /usr/share/latex2html sticky
	keepdir /usr/share/latex2html

	# clean the perl scripts up to remove references to the sandbox
	einfo "fixing sandbox references"
	# pstoimg isn't built unless gif or png useflags are enabled
	{ use png || use gif ; } && sed -i -e "s:${T}:/tmp:g" "${D}/usr/$(get_libdir)/latex2html/pstoimg.pl"
	sed -i -e "s:${S}::g" "${D}/usr/$(get_libdir)/latex2html/latex2html.pl" || die
	sed -i -e "s:${T}:/tmp:g" "${D}/usr/$(get_libdir)/latex2html/cfgcache.pm" || die
	sed -i -e "s:${T}:/tmp:g" "${D}/usr/$(get_libdir)/latex2html/l2hconf.pm" || die
}

pkg_postinst() {
	einfo "Running ${ROOT}usr/bin/mktexlsr to rebuild ls-R database...."
	"${ROOT}"usr/bin/mktexlsr
}

pkg_postrm() {
	einfo "Running ${ROOT}usr/bin/mktexlsr to rebuild ls-R database...."
	"${ROOT}"usr/bin/mktexlsr
}
