# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spyview/spyview-20130823.ebuild,v 1.4 2014/01/06 13:35:35 jlec Exp $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Fully decentralized P2P microblogging platform"
HOMEPAGE="http://twister.net.co/"
EGIT_REPO_URI="https://github.com/miguelfreitas/twister-core.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-libs/boost:=
	dev-libs/openssl
	net-libs/miniupnpc
	sys-libs/db
"

DEPEND="${COMMON_DEPEND}"

RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	cd "${S}"/libtorrent
	./bootstrap.sh
	cd "${S}"
}

src_configure() {
	cd "${S}"/libtorrent
	econf --enable-logging --enable-debug --enable-dht	
}

src_compile() {
	cd "${S}"/libtorrent
	emake
	cd "${S}"/src
	emake -f makefile.unix
}
