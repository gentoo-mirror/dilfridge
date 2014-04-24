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

EAPI=5

inherit readme.gentoo eutils base cmake-utils depend.php depend.apache multilib flag-o-matic

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
	dev-lang/perl
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



	mycmakeargs=(
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

	DOC_CONTENTS="
1. If this is a new installation, you will need to create a MySQL\n
   database for ${PN} to use\n
   (see https://wiki.gentoo.org/wiki/MySQL/Startup_Guide).\n
   E.g., when logged into mysql as root,\n
     mysql> CREATE DATABASE 'zm';\n
     mysql> GRANT ALL ON zm.* TO 'zmuser'@'localhost' IDENTIFIED BY 'topsecretpassword';\n
   Once you completed that you should execute the following:\n
     cd /usr/share/${PN}\n
     mysql -u zmuser -p < db/zm_create.sql\n
\n
2.  Set your database settings in /etc/zm.conf\n
\n
3. Check /etc/apache2/vhosts.d/10_zoneminder.conf\n
\n
4.  Enable PHP in your webserver configuration, \n
    enable short_open_tags in php.ini,\n
    set the time zone in php.ini, \n
    and restart/reload the webserver.\n
\n
5.  Start the ${PN} daemon:\n
  /etc/init.d/${PN} start\n
\n
6. Finally point your browser to http://localhost/${PN}\n
\n
If you are upgrading, you will need to run the zmupdate.pl script:\n
 /usr/bin/zmupdate.pl version= [--user= --pass=]\n
"

	readme.gentoo_src_install
}
