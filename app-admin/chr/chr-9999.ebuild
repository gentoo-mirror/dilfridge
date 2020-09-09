# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/akhuettel/chr.git"
inherit git-r3

DESCRIPTION="Set of chroot scripts, handled as OpenRC services"

HOMEPAGE="https://github.com/akhuettel/chr"
LICENSE="GPL-2"

KEYWORDS=""
IUSE=""

SLOT="0"

src_install() {
	doinitd init.d/chr
	doconfd conf.d/chr
}
