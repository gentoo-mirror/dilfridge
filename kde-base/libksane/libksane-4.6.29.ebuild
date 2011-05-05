# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-1.6.0.ebuild,v 1.1 2010/11/25 20:30:29 dilfridge Exp $

EAPI=4

DIGIKAMPN=digikam
DIGIKAMPV=2.0.0_beta5

KDE_OVERRIDE_MINIMAL="4.5.0"

inherit kde4-base

MY_P="${DIGIKAMPN}-${DIGIKAMPV/_/-}"

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=media-gfx/sane-backends-1.0.18"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/extra/${PN}
