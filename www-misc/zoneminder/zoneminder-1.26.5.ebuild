# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils base cmake-utils depend.php depend.apache multilib flag-o-matic

MY_PN="ZoneMinder"

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="gcrypt gnutls no-ffmpeg no-mmap no-x10 openssl pcre zlib"
SLOT="0"

DEPEND="
	zlib? ( sys-libs/zlib )
	virtual/jpeg
	openssl? ( dev-libs/openssl )
	dev-lang/perl
	pcre? ( dev-libs/libpcre )
	virtual/mysql
	gcrypt? ( dev-libs/libgcrypt )
	gnutls? ( net-libs/gnutls )
	!no-ffmpeg? ( virtual/ffmpeg )
	virtual/perl-Sys-Syslog
	dev-perl/DBI
	dev-perl/DBD-mysql
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes
	dev-perl/DateManip
	dev-perl/libwww-perl
	virtual/perl-ExtUtils-MakeMaker
	!no-mmap? ( dev-perl/Sys-Mmap )
"
S=${WORKDIR}/${MY_PN}-${PV}
CMAKE_IN_SOURCE_BUILD="ON"

need_apache
need_php_httpd

pkg_setup() {
	require_php_with_use mysql sockets apache2
}

src_configure() {
	append-cxxflags -D__STDC_CONSTANT_MACROS

	mycmakeargs="
		-DZM_WEBDIR=/var/www/zoneminder/htdocs
		-DZM_CGIDIR=/var/www/zoneminder/cgi-bin
		-DZM_WEB_USER=apache
		-DZM_WEB_GROUP=apache
	"
	if use no-mmap; then
		mycmakeargs="${mycmakeargs} -DZM_NO_MMAP=ON"
	fi
	if use no-x10; then
		mycmakeargs="${mycmakeargs} -DZM_NO_X10=ON"
	fi
	if use no-ffmpeg; then
		mycmakeargs="${mycmakeargs} -DZM_NO_FFMPEG=ON"
	fi
	cmake-utils_src_configure
}

src_compile() {
	einfo "${PN} does not parallel build... using forcing make -j1..."
	cmake-utils_src_make
}

src_install() {
	keepdir /var/log/zm

	cmake-utils_src_install

	fperms 0640 /etc/zm.conf

	fowners apache:apache /var/log/zm

	newinitd "${FILESDIR}"/init.d zoneminder
	newconfd "${FILESDIR}"/conf.d zoneminder

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL LICENSE NEWS README.md TODO

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
