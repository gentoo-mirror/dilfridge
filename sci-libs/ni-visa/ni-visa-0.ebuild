# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Placeholder for an NI-VISA library ebuild"

SRC_URI="NI-VISA-0.0.1.iso"
HOMEPAGE="http://www.ni.com/"
LICENSE="ni-visa"
KEYWORDS="~amd64 ~x86"
IUSE=""

SLOT="0"

RESTRICT="fetch"

src_install() {
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}/70nivisa"
}

pkg_nofetch() {
	elog
	elog Please download the NI-VISA library for linux from http://www.ni.com/ and install it.
	elog Afterwards run the command "echo > ${DISTDIR}/NI-VISA-0.0.1.iso"
	elog
	elog Yes I know this is an ugly hack but the NI installer is even uglier...
	elog
}
