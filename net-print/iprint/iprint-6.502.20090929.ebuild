# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DESCRIPTION="Micro Focus iPrint client"
HOMEPAGE="https://www.novell.com/products/openenterpriseserver/iprint.html"
SRC_URI="novell-iprint-xclient.x86_64.rpm"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="fetch mirror"

RDEPEND="
	net-print/cups
"
DEPEND="${RDEPEND}
"

S=${WORKDIR}

QA_PRESTRIPPED="/opt/novell/lib32/libiprint-ui.so.1.0.0 /opt/novell/lib32/libiprint.so.1.0.0 /opt/novell/iprint/bin/iprntcmd /opt/novell/iprint/plugin/libiprint-plugin32.so /opt/novell/iprint/plugin/npnipp32.so"

src_install() {
	mv -v "${WORKDIR}"/* "${D}/" || die

	mv -v "${D}/usr/lib" "${D}/usr/lib32" || die
	mv -v "${D}/opt/novell/lib" "${D}/opt/novell/lib32" || die

	rm -rf "${D}/etc/init.d" || die
	rm -rf "${D}/usr/sbin" || die

	sed -e 's:/lib$:/lib32:g' -i "${D}/etc/ld.so.conf.d/novell-iprint-xclient" || die

	mkdir -p "${D}/usr/lib32/nsbrowser" || die
	mkdir -p "${D}/usr/lib64/nsbrowser" || die
	mv -v "${D}/usr/lib32/browser-plugins" "${D}/usr/lib32/nsbrowser/plugins" || die
	mv -v "${D}/usr/lib64/browser-plugins" "${D}/usr/lib64/nsbrowser/plugins" || die

	keepdir /var/opt/novell/log/iprint/client
}
