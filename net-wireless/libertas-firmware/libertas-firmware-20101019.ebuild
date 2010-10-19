# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

MY_P=${P/-firmware/}

DESCRIPTION="Firmware for the Marvell Libertas chipsets (OLPC, GuruPlug)"

HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=libertas;hb=HEAD"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="libertas-fw"
KEYWORDS="~arm"

IUSE=""
DEPEND=""
RDEPEND=""
SLOT=0

src_install() {
	insinto $(get_libdir)/firmware
	doins *.bin || die
}
