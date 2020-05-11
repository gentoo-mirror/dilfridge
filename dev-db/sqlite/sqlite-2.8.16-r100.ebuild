# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils alternatives multilib toolchain-funcs

KEYWORDS="~amd64"

DESCRIPTION="SQLite: an SQL Database Engine in a C Library"
HOMEPAGE="http://www.sqlite.org/"
SRC_URI="http://www.sqlite.org/${P}.tar.gz"

LICENSE="public-domain"
SLOT="2"
IUSE="nls"

DEPEND=""

RDEPEND="
	!=dev-db/sqlite-2*:0
"

src_prepare() {
	eapply \
		"${FILESDIR}"/${P}-multilib.patch \
		"${FILESDIR}"/${P}-exit.patch

	if use nls ; then
		ENCODING=${ENCODING-"UTF8"}
	else
		ENCODING="ISO8859"
	fi

	sed -i -e "s:@@S@@:${S}:g" \
		-e "s:@@CC@@:$(tc-getCC):g" \
		-e "s:@@CFLAGS@@:${CFLAGS}:g" \
		-e "s:@@AR@@:$(tc-getAR):g" \
		-e "s:@@RANLIB@@:$(tc-getRANLIB):g" \
		-e "s:@@ENCODING@@:${ENCODING}:g" \
		"${S}"/Makefile.linux-gcc

	sed -i \
		-e '/^LTLINK/s:$(TCC):& $(LDFLAGS):' \
		-e '/lemon/s:-o:$(LDFLAGS) &:' \
		"${S}"/{main.mk,Makefile.in}

	default
}

src_configure() {
	local myconf="--enable-incore-db --enable-tempdb-in-ram"

	myconf="${myconf} --without-tcl"

	econf ${myconf} \
		--disable-static \
		$(use_enable nls utf8)
}

src_install () {
	dodir /usr/$(get_libdir)

	make DESTDIR="${D}" install || die "make install failed"

	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc README VERSION

	rm -rf "${D}/usr/bin" "${D}/usr/share/man" "${D}/usr/include" "${D}/usr/$(get_libdir)/pkgconfig"
}
