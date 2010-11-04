# Copyright 2010-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=3
inherit cmake-utils nsplugins

DESCRIPTION="This plugin uses KDE's KParts technology to embed file viewers into non-KDE browsers"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~fischer/kpartsplugin/"
SRC_URI="http://www.unix-ag.uni-kl.de/~fischer/kpartsplugin/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=kde-base/kdelibs-4.3"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_prepare() {
	sed -e :/usr/lib/nsbrowser/plugins/:/usr/$(get_libdir)/${PLUGINS_DIR}/: -i CMakeLists.txt \
	    || die "sed failed"
}
