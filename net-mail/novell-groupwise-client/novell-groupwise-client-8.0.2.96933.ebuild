# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NOVELL_BUILDID="_XAeStjRFu8~"
NOVELL_FILE32="patchfiles/gw802_hp3_full_linux_multi.tar.gz"
RESTRICT="fetch mirror strip"

inherit eutils rpm5 multilib versionator

MY_PV=$(replace_version_separator 3 '-')
MY_P="${P/_p/-}"

DESCRIPTION="Novell Groupwise 8 Client for Linux"
HOMEPAGE="http://www.novell.com/en/gropwise/"
SRC_URI="http://${NOVELL_ACCOUNT_USERNAME}:${NOVELL_ACCOUNT_PASSWORD}@cdn.novell.com/prot/${NOVELL_BUILDID}/${NOVELL_FILE32}"

LICENSE="Novell-GW-8"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="novell-jre multilib"
DEPEND=""
RDEPEND="sys-libs/glibc
	sys-libs/libstdc++-v3
	sys-devel/gcc
	!novell-jre? (
		|| ( virtual/jdk
		virtual/jre )
		multilib? (
		amd64? ( app-emulation/emul-linux-x86-java ) ) )
	multilib? (
		amd64? ( app-emulation/emul-linux-x86-compat ) )"

src_unpack() {
	unpack ${A}
	mkdir -p "${WORKDIR}"/${PN}-${MY_PV}
	cd ${PN}-${MY_PV}
	rpm5_unpack ./../gw${MY_PV}_full_linux_multi/client/linux/${PN}-${MY_PV}.i586.rpm
}

src_compile() { :; }

src_install() {
	JRE_DIR="${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java;

	if use novell-jre; then
		# Undo Sun's funny-business with packed .jar's
		for i in $JRE_DIR/lib/*.pack; do
		i_b=`echo $i | sed 's/\.pack$//'`;
		einfo "Unpacking `basename $i` -> `basename $i_b.jar`";
		$JRE_DIR/bin/unpack200 $i $i_b.jar || die "Unpack failed";
		done;
	else
		if use multilib; then
		rm -rf "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java
		sed -i 's%/opt/novell/groupwise/client/java/lib/i386%`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386/client:`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386/server:`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386%' "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/bin/groupwise
		else
		rm -rf "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java
		sed -i 's%/opt/novell/groupwise/client/java/lib/i386%`java-config --jre-home`/jre/lib/i386/client:`java-config --jre-home`/jre/lib/i386/server:`java-config --jre-home`/jre/lib/i386%' "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/bin/groupwise
		fi
	fi

	insinto /usr/share/applications
	doins "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/gwclient.desktop

	mv "${WORKDIR}"/${PN}-${MY_PV}/opt "${D}"/ || die "mv opt"

	dodir /opt/bin
	dosym /opt/novell/groupwise/client/bin/groupwise /opt/bin/groupwise
}

pkg_nofetch() {
	einfo "This files require you to register at ${HOMEPAGE} (free account)"
	einfo "Please download following file:"
	einfo " - ${NOVELL_FILE32}"
	einfo "from http://download.novell.com/Download?buildid=${NOVELL_BUILDID}"
	einfo "and place it in ${DISTDIR}"
}
