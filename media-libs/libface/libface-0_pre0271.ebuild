# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils subversion

DESCRIPTION="Face recognition library"
HOMEPAGE="http://libface.sourceforge.net/"
ESVN_REPO_URI="https://libface.svn.sourceforge.net/svnroot/libface/trunk@271"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT=0
IUSE=""

RDEPEND="media-libs/opencv"
DEPEND="${RDEPEND}"
