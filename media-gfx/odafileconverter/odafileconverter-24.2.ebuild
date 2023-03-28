# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm desktop

DESCRIPTION="Open Design Alliance DWG-DXF Converter"
HOMEPAGE="https://www.opendesign.com/guestfiles/oda_file_converter"

SRC_URI="https://download.opendesign.com/guestfiles/Demo/ODAFileConverter_QT5_lnxX64_8.3dll_${PV}.rpm"

KEYWORDS="-* ~amd64"
SLOT="0"
LICENSE="all-rights-reserved"

RESTRICT="mirror bindist"

RDEPEND="
	media-libs/tiff-compat:4
"

S=${WORKDIR}

QA_PREBUILT="*"

src_install() {
	# we dont want automated desktop icons
	rm -r "${S}"/etc

	# move stuff from /usr/local/bin to /opt
	dodir /opt
	mv "${S}"/usr/local/bin/ODAFileConverter* "${D}"/opt/

	# adjust path and move again
	sed -e 's:/usr/local/bin/:/opt/:g' -i "${D}"/opt/ODAFileConverter
	dodir /opt/bin
	mv "${D}"/opt/ODAFileConverter "${D}"/opt/bin/ODAFileConverter

	# the desktop files
	domenu "${S}"/usr/share/applications/ODAFileConverter.desktop

	# the icons, simpler by hand
	dodir /usr/share/icons
	mv "${S}"/usr/share/icons/* "${D}"/usr/share/icons/
}
