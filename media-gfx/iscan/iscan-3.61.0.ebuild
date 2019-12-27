# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="EPSON Image Scan v3 for Linux"
HOMEPAGE="http://support.epson.net/linux/en/imagescanv3.php"

SRC_URI="http://support.epson.net/linux/src/scanner/imagescanv3/common/imagescan_${PV}.orig.tar.gz"

LICENSE="GPL-3+"

SLOT="0"

IUSE="gtk imagemagick"

# KEYWORDS="~amd64"
# No keywords since I havent really gotten it to work yet.

DEPEND="
	dev-libs/boost:=
	media-gfx/sane-backends
	media-libs/tiff
	virtual/libusb:1
	virtual/jpeg
	gtk? ( dev-cpp/gtkmm:= )
	imagemagick? ( || (
		media-gfx/imagemagick
		media-gfx/graphicsmagick
	) )
"
RDEPEND=${DEPEND}
# gtkmm: 2 or 3? here I have only 2 and it builds

S="${WORKDIR}/utsushi-0.$(ver_cut 2-3)"

src_configure() {
	econf \
		$(use_with gtk gtkmm) \
		--with-jpeg \
		$(use_with imagemagick magick) \
		$(use_with imagemagick magick-pp) \
		--with-tiff \
		--with-sane \
		--with-boost=yes
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
