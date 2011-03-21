# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.4.0-r1.ebuild,v 1.3 2011/01/29 17:26:48 scarabeus Exp $

EAPI=3
PYTHON_DEPEND="2:2.6"
inherit distutils

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://synaptiks.lunaryorn.de/"
SRC_URI="https://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND=">=dev-python/PyQt4-4.7
	>=kde-base/pykde4-4.5
	kde-base/kdesdk-scripts
	>=x11-libs/libXi-1.4
	app-text/docbook-xsl-stylesheets
	>=dev-python/pyudev-0.6
	|| ( >=dev-lang/python-2.7 dev-python/argparse )
	>=x11-drivers/xf86-input-synaptics-1.3"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S=${WORKDIR}/lunaryorn-synaptiks-2b7d696

src_install() {
	distutils_src_install --single-version-externally-managed
}
