# Copyright 1999-2019 Gentoo Authors
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

QA_PRESTRIPPED="/opt/novell/iprint/bin/iprntcmd"

src_install() {
	mv "${WORKDIR}"/* "${D}/" || die

	# The browser plugin is completely broken by now.
	# (It needs libxpcom.so which is gone for years.)
	rm -r "${D}"/usr/lib{64,}/browser-plugins
	rm -r "${D}"/usr/lib{64,}/firefox
	rm -r "${D}"/usr/lib{64,}/mozilla
	rm -r "${D}/opt/novell/iprint/plugin"

	# We dont need the rc-scripts since this is not a system
	# service. Whoever wrote the package misunderstood something.
	rm "${D}"/usr/sbin/rcnovell-iprint-listener*
	rm "${D}"/etc/init.d/novell-iprint-listener*

	# The log dir
	keepdir /var/opt/novell/log/iprint/client
}
