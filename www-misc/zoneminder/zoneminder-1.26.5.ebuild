# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TO DO:
# * ffmpeg support can be disabled in CMakeLists.txt but it does not build then 
#		$(cmake-utils_useno ffmpeg ZM_NO_FFMPEG)
# * dependencies of unknown status:
# 	app-admin/sudo
# 	dev-perl/Archive-Zip
# 	dev-perl/Device-SerialPort
# 	dev-perl/MIME-Lite
# 	dev-perl/MIME-tools
# 	dev-perl/PHP-Serialization
# 	virtual/perl-Archive-Tar
# 	virtual/perl-libnet
# 	virtual/perl-Module-Load
# * apache integration
# * installation of files into real webdir
# * the perl modules go into weird places atm

EAPI=5

PERL_EXPORT_PHASE_FUNCTIONS=no

inherit perl-module readme.gentoo eutils base cmake-utils depend.php depend.apache multilib flag-o-matic

MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="gcrypt gnutls mmap +openssl vlc"
SLOT="0"

REQUIRED_USE="
	|| ( openssl gnutls )
"

DEPEND="
	dev-lang/perl:=
	dev-libs/libpcre
	dev-perl/DateManip
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/libwww-perl
	sys-libs/zlib
	virtual/ffmpeg
	virtual/jpeg
	virtual/mysql
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Getopt-Long
	virtual/perl-Sys-Syslog
	virtual/perl-Time-HiRes
	gcrypt? ( dev-libs/libgcrypt )
	gnutls? ( net-libs/gnutls )
	mmap? ( dev-perl/Sys-Mmap )
	openssl? ( dev-libs/openssl )
	vlc? ( media-video/vlc )
"
RDEPEND="${DEPEND}"

# we cannot use need_httpd_cgi here, since we need to setup permissions for the
# webserver in global scope (/etc/zm.conf etc), so we hardcode apache here.
need_apache
need_php_httpd

S=${WORKDIR}/${MY_PN}-${PV}

PATCHES=(
	"${FILESDIR}/${PN}-1.26.5"-automagic.patch
)

pkg_setup() {
	require_php_with_use mysql sockets apache2
}

src_configure() {
	append-cxxflags -D__STDC_CONSTANT_MACROS
	perl_set_version

	mycmakeargs=(
		-DZM_PERL_SUBPREFIX=${VENDOR_LIB}
		-DZM_TMPDIR=/var/tmp/zm
		-DZM_WEB_USER=apache
		-DZM_WEB_GROUP=apache
		$(cmake-utils_useno mmap ZM_NO_MMAP)
		-DZM_NO_X10=OFF
		-DZM_NO_FFMPEG=OFF
		$(cmake-utils_useno vlc ZM_NO_VLC)
		$(cmake-utils_useno openssl CMAKE_DISABLE_FIND_PACKAGE_OpenSSL)
		$(cmake-utils_use_has gnutls)
		$(cmake-utils_use_has gcrypt)
	)

	cmake-utils_src_configure
}

src_install() {
	keepdir /var/log/zm

	cmake-utils_src_install

	fperms 0640 /etc/zm.conf
	fowners root:apache /etc/zm.conf

	fowners apache:apache /var/log/zm

	newinitd "${FILESDIR}"/init.d zoneminder
	newconfd "${FILESDIR}"/conf.d zoneminder

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README.md TODO

#	insinto /etc/apache2/vhosts.d
#	doins "${FILESDIR}"/10_zoneminder.conf
#
#	for DIR in events images sound; do
#	    dodir /var/www/zoneminder/htdocs/${DIR}
#	done

	readme.gentoo_src_install
}
