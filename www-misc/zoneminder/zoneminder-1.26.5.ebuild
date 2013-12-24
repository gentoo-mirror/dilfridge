# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TO DO:
# permissions on /tmp/zm, or use alternate directory

EAPI=5

inherit eutils base cmake-utils depend.php depend.apache multilib flag-o-matic

MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="gcrypt gnutls +openssl debug ffmpeg mmap vlc"
SLOT="0"

REQUIRED_USE="
	|| ( openssl gnutls )
"

DEPEND="
	virtual/perl-Sys-Syslog
	dev-perl/DBI
	dev-perl/DBD-mysql
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes
	dev-perl/DateManip
	dev-perl/libwww-perl
	virtual/perl-ExtUtils-MakeMaker
	virtual/mysql
	dev-lang/perl
	dev-libs/libpcre
	sys-libs/zlib
	virtual/jpeg
	gcrypt? ( dev-libs/libgcrypt )
	gnutls? ( net-libs/gnutls )
	openssl? ( dev-libs/openssl )
	ffmpeg? ( virtual/ffmpeg )
	mmap? ( dev-perl/Sys-Mmap )
	vlc? ( media-video/vlc )
"

RDEPEND="${DEPEND}"

# dependencies of unknown status:
# 	app-admin/sudo
# 	dev-perl/Archive-Zip
# 	dev-perl/Device-SerialPort
# 	dev-perl/MIME-Lite
# 	dev-perl/MIME-tools
# 	dev-perl/PHP-Serialization
# 	virtual/perl-Archive-Tar
# 	virtual/perl-libnet
# 	virtual/perl-Module-Load

# we cannot use need_httpd_cgi here, since we need to setup permissions for the
# webserver in global scope (/etc/zm.conf etc), so we hardcode apache here.
need_apache
need_php_httpd

S=${WORKDIR}/${MY_PN}-${PV}

PATCHES=(
	"${FILESDIR}"/1.24.2/db_upgrade_script_location.patch
)

pkg_setup() {
	require_php_with_use mysql sockets apache2
}

src_configure() {
	append-cxxflags -D__STDC_CONSTANT_MACROS

	mycmakeargs=(
		-DZM_WEBDIR=/var/www/zm/htdocs
		-DZM_CGIDIR=/var/www/zm/cgi-bin
		-DZM_CONTENTDIR=/var/lib/zm
		-DZM_WEB_USER=apache
		-DZM_WEB_GROUP=apache
		$(cmake-utils_useno mmap ZM_NO_MMAP)
		-DZM_NO_X10=OFF
		$(cmake-utils_useno ffmpeg ZM_NO_FFMPEG)
		$(cmake-utils_useno vlc ZM_NO_VLC)
	)

	cmake-utils_src_configure
}

src_install() {
	keepdir /var/log/zm

	cmake-utils_src_install

	fperms 0640 /etc/zm.conf

	fowners apache:apache /var/log/zm

	newinitd "${FILESDIR}"/init.d zoneminder
	newconfd "${FILESDIR}"/conf.d zoneminder

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README.md TODO

	insinto /usr/share/${PN}/db
	doins db/zm_u* db/zm_create.sql

	#insinto /etc/apache2/vhosts.d
	#doins "${FILESDIR}"/10_zoneminder.conf

	for DIR in events images sound; do
	    dodir /var/www/zoneminder/htdocs/${DIR}
	done
}

pkg_postinst() {
	elog ""
	elog "0. If this is a new installation, you will need to create a MySQL database"
	elog "   for ${PN} to use. (see http://www.gentoo.org/doc/en/mysql-howto.xml)."
	elog "   Once you completed that you should execute the following:"
	elog " cd /usr/share/${PN}"
	elog " mysql -u  -p  < db/zm_create.sql"
	elog ""
	elog "1.  Set your database settings in /etc/zm.conf"
	elog ""
	elog "2.  Enable PHP in your webserver configuration, enable short_open_tags in php.ini,"
	elog "    set the time zone in php.ini, and restart/reload the webserver"
	elog ""
	elog "3.  Start the ${PN} daemon:"
	elog "  /etc/init.d/${PN} start"
	elog ""
	elog "4. Finally point your browser to http://localhost/${PN}"
	elog ""
	elog "If you are upgrading, you will need to run the zmupdate.pl script:"
	elog " /usr/bin/zmupdate.pl version= [--user= --pass=]"
	elog ""
}
