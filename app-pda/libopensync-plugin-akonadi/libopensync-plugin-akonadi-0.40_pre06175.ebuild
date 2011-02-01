# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base subversion

DESCRIPTION="OpenSync Akonadi (KDE4) Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/akonadi-sync/trunk@6175"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="=app-pda/libopensync-${PV}*
	=app-pda/libopensync-plugin-vformat-${PV}*
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}"
