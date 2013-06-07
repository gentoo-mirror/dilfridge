# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="Find how deeply inside an .RPM the real data is"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/cpio
	|| ( app-arch/lzma-utils app-arch/xz-utils )"
DEPEND="${DEPEND}"

src_compile() {
	"$(tc-getCC)" ${CFLAGS} ${LDFLAGS} "${FILESDIR}"/rpmoffset.c -o rpm5offset || die
}

src_install() {
	dobin rpm5offset || die
}
