# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice/libreoffice-3.4.1.ebuild,v 1.7 2011/07/18 14:22:33 scarabeus Exp $

EAPI=3

KDE_REQUIRED="optional"
CMAKE_REQUIRED="never"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="threads,xml"

inherit base autotools check-reqs db-use eutils fdo-mime flag-o-matic gnome2-utils java-pkg-opt-2 kde4-base multilib pax-utils prefix python toolchain-funcs

DESCRIPTION="LibreOffice, a full office productivity suite."
HOMEPAGE="http://www.libreoffice.org"
DEV_URI="http://download.documentfoundation.org/libreoffice/src"
EXT_URI="http://ooo.itc.hu/oxygenoffice/download/libreoffice"
ADDONS_URI="http://dev-www.libreoffice.org/src/"
SRC_URI="odk? ( java? ( http://tools.openoffice.org/unowinreg_prebuild/680/unowinreg.dll ) )"

# Shiny split sources with so many packages...
MODULES="artwork base calc components extensions extras filters help
impress libs-core libs-extern libs-extern-sys libs-gui postprocess sdk testing
ure writer translations"
# split out as bootstrap is required to be done first
SRC_URI+=" ${DEV_URI}/${PN}-bootstrap-${PV}.tar.bz2"
for mod in ${MODULES}; do
	SRC_URI+=" ${DEV_URI}/${PN}-${mod}-${PV}.tar.bz2"
done
unset mod

# addons
ADDONS_SRC+=" ${ADDONS_URI}/48a9f787f43a09c0a9b7b00cd1fddbbf-hyphen-2.7.1.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/09357cc74975b01714e00c5899ea1881-pixman-0.12.0.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/128cfc86ed5953e57fe0f5ae98b62c2e-libtextcat-2.2.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip"
ADDONS_SRC+=" ${ADDONS_URI}/1756c4fa6c616ae15973c104cd8cb256-Adobe-Core35_AFMs-314.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/18f577b374d60b3c760a3a3350407632-STLport-4.5.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/1f24ab1d39f4a51faf22244c94a6203f-xmlsec1-1.2.14.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/24be19595acad0a2cae931af77a0148a-LICENSE_source-9.0.0.7-bj.html"
ADDONS_SRC+=" ${ADDONS_URI}/26b3e95ddf3d9c077c480ea45874b3b8-lp_solve_5.5.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/284e768eeda0e2898b0d5bf7e26a016e-raptor-1.4.18.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/2a177023f9ea8ec8bd00837605c5df1b-jakarta-tomcat-5.0.30-src.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/ca4870d899fd7e943ffc310a5421ad4d-liberation-fonts-ttf-1.06.0.20100721.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/35c94d2df8893241173de1d16b6034c0-swingExSrc.zip"
ADDONS_SRC+=" ${ADDONS_URI}/35efabc239af896dfb79be7ebdd6e6b9-gentiumbasic-fonts-1.10.zip"
ADDONS_SRC+=" ${ADDONS_URI}/39bb3fcea1514f1369fcfc87542390fd-sacjava-1.3.zip"
ADDONS_SRC+=" ${ADDONS_URI}/3ade8cfe7e59ca8e65052644fed9fca4-epm-3.7.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/48470d662650c3c074e1c3fabbc67bbd-README_source-9.0.0.7-bj.txt"
ADDONS_SRC+=" ${ADDONS_URI}/4a660ce8466c9df01f19036435425c3a-glibc-2.1.3-stub.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/599dc4cc65a07ee868cf92a667a913d2-xpdf-3.02.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/7376930b0d3f3d77a685d94c4a3acda8-STLport-4.5-0119.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/798b2ffdc8bcfe7bca2cf92b62caf685-rhino1_5R5.zip"
ADDONS_SRC+=" ${ADDONS_URI}/8294d6c42e3553229af9934c5c0ed997-stax-api-1.0-2-sources.jar"
ADDONS_SRC+=" ${ADDONS_URI}/a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip"
ADDONS_SRC+=" ${ADDONS_URI}/ada24d37d8d638b3d8a9985e80bc2978-source-9.0.0.7-bj.zip"
ADDONS_SRC+=" ${ADDONS_URI}/c441926f3a552ed3e5b274b62e86af16-STLport-4.0.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/d4c4d91ab3a8e52a2e69d48d34ef4df4-core.zip"
ADDONS_SRC+=" ${ADDONS_URI}/e0707ff896045731ff99e99799606441-README_db-4.7.25.NC-custom.txt"
ADDONS_SRC+=" ${ADDONS_URI}/fca8706f2c4619e2fa3f8f42f8fc1e9d-rasqal-0.9.16.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/fdb27bfe2dbe2e7b57ae194d9bf36bab-SampleICC-1.3.2.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/37282537d0ed1a087b1c8f050dc812d9-dejavu-fonts-ttf-2.32.zip"
ADDONS_SRC+=" ${ADDONS_URI}/067201ea8b126597670b5eff72e1f66c-mythes-1.2.0.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/3404ab6b1792ae5f16bbd603bd1e1d03-libformula-1.1.7.zip"
ADDONS_SRC+=" ${ADDONS_URI}/3bdf40c0d199af31923e900d082ca2dd-libfonts-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/8ce2fcd72becf06c41f7201d15373ed9-librepository-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/97b2d4dba862397f446b217e2b623e71-libloader-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/db60e4fde8dd6d6807523deb71ee34dc-liblayout-0.2.10.zip"
ADDONS_SRC+=" ${ADDONS_URI}/eeb2c7ddf0d302fba4bfc6e97eac9624-libbase-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/f94d9870737518e3b597f9265f4e9803-libserializer-1.1.6.zip"
ADDONS_SRC+=" ${ADDONS_URI}/ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip"
ADDONS_SRC+=" ${ADDONS_URI}/451ccf439a36a568653b024534669971-ConvertTextToNumber-1.3.2.oxt"
ADDONS_SRC+=" ${ADDONS_URI}/47e1edaa44269bc537ae8cabebb0f638-JLanguageTool-1.0.0.tar.bz2"
ADDONS_SRC+=" ${ADDONS_URI}/90401bca927835b6fbae4a707ed187c8-nlpsolver-0.9.tar.bz2"
ADDONS_SRC+=" ${ADDONS_URI}/0f63ee487fda8f21fafa767b3c447ac9-ixion-0.2.0.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/71474203939fafbe271e1263e61d083e-nss-3.12.8-with-nspr-4.8.6.tar.gz"
ADDONS_SRC+=" ${ADDONS_URI}/7a0dcb3fe1e8c7229ab4fb868b7325e6-mdds_0.5.2.tar.bz2"
ADDONS_SRC+=" ${ADDONS_URI}/0625a7d661f899a8ce263fc8a9879108-graphite2-0.9.2.tgz"
ADDONS_SRC+=" http://download.go-oo.org/extern/185d60944ea767075d27247c3162b3bc-unowinreg.dll"
ADDONS_SRC+=" http://download.go-oo.org/extern/b4cae0700aa1c2aef7eb7f345365e6f1-translate-toolkit-1.8.1.tar.bz2"
ADDONS_SRC+=" http://www.numbertext.org/linux/881af2b7dca9b8259abbca00bbbc004d-LinLibertineG-20110101.zip"
SRC_URI+=" ${ADDONS_SRC}"

# translations
LANGUAGES="af ar as ast be bg bn bo br brx bs ca ca_XV cs cy da de dgo dz el
en en_GB en_ZA eo es et eu fa fi fr ga gl gu he hi hr hu id is it ja ka kk km
kn kok ko ks ku lo lt lv mai mk ml mn mni mr my nb ne nl nn nr nso oc or
pa_IN pl pt pt_BR ro ru rw sat sd sh sk sl sq sr ss st sv sw_TZ ta te tg
th tn tr ts ug uk uz ve vi xh zh_CN zh_TW zu"
for X in ${LANGUAGES} ; do
	IUSE+=" linguas_${X}"
done
unset X

# intersection of available linguas and app-dicts/myspell-* dictionaries
SPELL_DIRS="af bg ca cs cy da de el en eo es et fr ga gl he hr hu it ku lt mk nb
nl nn pl pt ru sk sl sv tn zu"
for X in ${SPELL_DIRS} ; do
	SPELL_DIRS_DEPEND+=" linguas_${X}? ( app-dicts/myspell-${X} )"
done
unset X

TDEPEND="${EXT_URI}/472ffb92d82cf502be039203c606643d-Sun-ODF-Template-Pack-en-US_1.0.0.oxt"
TDEPEND+=" linguas_de? ( ${EXT_URI}/53ca5e56ccd4cab3693ad32c6bd13343-Sun-ODF-Template-Pack-de_1.0.0.oxt )"
TDEPEND+=" linguas_en_GB? ( ${EXT_URI}/472ffb92d82cf502be039203c606643d-Sun-ODF-Template-Pack-en-US_1.0.0.oxt )"
TDEPEND+=" linguas_en_ZA? ( ${EXT_URI}/472ffb92d82cf502be039203c606643d-Sun-ODF-Template-Pack-en-US_1.0.0.oxt )"
TDEPEND+=" linguas_es? ( ${EXT_URI}/4ad003e7bbda5715f5f38fde1f707af2-Sun-ODF-Template-Pack-es_1.0.0.oxt )"
TDEPEND+=" linguas_fr? ( ${EXT_URI}/a53080dc876edcddb26eb4c3c7537469-Sun-ODF-Template-Pack-fr_1.0.0.oxt )"
TDEPEND+=" linguas_hu? ( ${EXT_URI}/09ec2dac030e1dcd5ef7fa1692691dc0-Sun-ODF-Template-Pack-hu_1.0.0.oxt )"
TDEPEND+=" linguas_it? ( ${EXT_URI}/b33775feda3bcf823cad7ac361fd49a6-Sun-ODF-Template-Pack-it_1.0.0.oxt )"
SRC_URI+=" templates? ( ${TDEPEND} )"

unset ADDONS_URI
unset EXT_URI
unset ADDONS_SRC

IUSE+=" binfilter cups custom-cflags dbus debug eds gnome gstreamer
gtk kde ldap mysql nsplugin odk offlinehelp opengl pch python templates webdav"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

COMMON_DEPEND="
	app-arch/zip
	app-arch/unzip
	>=app-text/hunspell-1.1.4-r1
	app-text/mythes
	app-text/libwpd:0.9[tools]
	>=app-text/libwps-0.2.2
	>=app-text/poppler-0.12.3-r3[xpdf-headers]
	dev-db/unixODBC
	dev-libs/expat
	>=dev-libs/glib-2.18
	>=dev-libs/icu-4.0
	>=dev-lang/perl-5.0
	>=dev-libs/openssl-0.9.8g
	dev-libs/redland[ssl]
	media-libs/freetype:2
	>=media-libs/fontconfig-2.3.0
	>=media-libs/vigra-1.4
	media-libs/libpng
	media-libs/libwpg:0.2
	>=sys-libs/db-4.8
	virtual/jpeg
	>=x11-libs/cairo-1.0.2
	x11-libs/libXaw
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	cups? ( net-print/cups )
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	gnome? (
		>=x11-libs/gtk+-2.10:2
		gnome-base/gconf:2
	)
	gtk? ( >=x11-libs/gtk+-2.10:2 )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10
	)
	java? (
		>=dev-java/bsh-2.0_beta4
		dev-java/lucene:2.9
		dev-java/lucene-analyzers:2.3
		dev-java/saxon:0
	)
	ldap? ( net-nds/openldap )
	mysql? ( dev-db/mysql-connector-c++ )
	nsplugin? (
		net-libs/xulrunner:1.9
		>=dev-libs/nspr-4.6.6
		>=dev-libs/nss-3.11-r1
	)
	opengl? ( virtual/opengl )
	webdav? ( net-libs/neon )
"

RDEPEND="${COMMON_DEPEND}
	!app-office/libreoffice-bin
	!app-office/openoffice-bin
	!app-office/openoffice
	java? ( >=virtual/jre-1.5 )
	${SPELL_DIRS_DEPEND}
"

DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.36
	>=dev-libs/libxml2-2.0
	dev-libs/libxslt
	dev-perl/Archive-Zip
	dev-util/cppunit
	>=dev-util/gperf-3
	dev-util/intltool
	dev-util/pkgconfig
	media-gfx/sane-backends
	>=net-misc/curl-7.12
	>=sys-apps/findutils-4.1.20-r1
	sys-devel/bison
	sys-apps/coreutils
	sys-devel/flex
	sys-libs/zlib
	x11-libs/libXtst
	x11-proto/printproto
	x11-proto/randrproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
	java? (
		=virtual/jdk-1.6*
		>=dev-java/ant-core-1.7
		dev-java/junit:4
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-3.3.1-neon_remove_SSPI_support.diff"
	"${FILESDIR}/${PN}-libdb5-fix-check.diff"
	"${FILESDIR}/${PN}-3.4.1-salfix.diff"
	"${FILESDIR}/sdext-presenter.diff"
)

# Uncoment me when updating to eapi4
# REQUIRED_USE="
#	|| ( gtk gnome kde )
#	gnome? ( gtk )
#"

S="${WORKDIR}/${PN}-bootstrap-${PV}"

pkg_setup() {
	java-pkg-opt-2_pkg_setup
	kde4-base_pkg_setup

	python_set_active_version 2
	python_pkg_setup

	if use custom-cflags; then
		ewarn "You are using custom CFLAGS, which is NOT supported and can cause"
		ewarn "all sorts of build and runtime errors."
		ewarn
		ewarn "Before reporting a bug, please make sure you rebuild and try with"
		ewarn "basic CFLAGS, otherwise the bug will not be accepted."
		ewarn
	fi

	if ! use java; then
		ewarn "You are building with java-support disabled, this results in some"
		ewarn "of the LibreOffice functionality being disabled."
		ewarn "If something you need does not work for you, rebuild with"
		ewarn "java in your USE-flags."
		ewarn
		ewarn "Some java libraries will be provided internally by libreoffice"
		ewarn "during the build. You should really reconsider enabling java"
		ewarn "use flag."
		ewarn
	fi

	if ! use gtk; then
		ewarn "If you want the LibreOffice systray quickstarter to work"
		ewarn "activate the 'gtk' use flag."
		ewarn
	fi

	# Check if we have enough RAM and free diskspace to build this beast
	CHECKREQS_MEMORY="512"
	use debug && CHECKREQS_DISK_BUILD="12288" || CHECKREQS_DISK_BUILD="7144"
	check_reqs
}

src_unpack() {
	local mod dest tmplfile tmplname

	#first the bootstrap files
	unpack "${PN}-bootstrap-${PV}.tar.bz2"

	# and then all the separate modules
	for mod in ${MODULES}; do
		unpack "${PN}-${mod}-${PV}.tar.bz2"
		mv -n "${WORKDIR}/${PN}-${mod}-${PV}"/* "${S}"
		# punt the empty dirs; it is annoying during debuging :)
		rm -rf "${WORKDIR}/${PN}-${mod}-${PV}"
	done

	# don't forget the wrapper...
	cp "${FILESDIR}"/wrapper.in "${T}"

	# copy extension templates; o what fun ...
	if use templates; then
		dest="${S}/extras/source/extensions"
		mkdir -p "${dest}"

		for template in ${TDEPEND}; do
			if [[ ${template} == *.oxt ]]; then
				tmplfile="${DISTDIR}/$(basename ${template})"
				tmplname="$(echo "${template}" | \
					cut -f 2- -s -d - | cut -f 1 -d _)"
				echo ">>> Unpacking ${tmplfile/\*/} to ${dest}"
				if [[ -f ${tmplfile} && ! -f "${dest}/${tmplname}.oxt" ]]; then
					cp -v "${tmplfile}" "${dest}/${tmplname}.oxt" || die
				fi
			fi
		done
	fi
}

src_prepare() {
	eprefixify "${T}"/wrapper.in

	strip-linguas ${LANGUAGES}
	LINGUAS_OOO=$(echo ${LINGUAS} | sed -e 's/\ben\b/en_US/;s/_/-/g')

	# Now for our optimization flags ...
	export ARCH_FLAGS="${CXXFLAGS}"
	use debug || export LINKFLAGSOPTIMIZE="${LDFLAGS}"

	# compiler flags
	use custom-cflags || strip-flags
	use debug || filter-flags "-g*"
	# silent miscompiles; LO/OOo adds -O2/1/0 where appropriate
	filter-flags "-O*"

	if [[ $(gcc-major-version) -lt 4 ]]; then
		filter-flags "-fstack-protector"
		filter-flags "-fstack-protector-all"
		replace-flags "-fomit-frame-pointer" "-momit-leaf-frame-pointer"
	fi

	base_src_prepare
	eautoreconf
}

src_configure() {
	local java_opts
	local internal_libs
	local extensions
	local themes="default"
	local jobs=$(echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/")

	# ensure that qt4 and kdedir are properly located
	if use kde; then
		export KDE4DIR="${KDEDIR}"
		export QT4LIB="${EPREFIX}/usr/$(get_libdir)/qt4"
	fi

	# expand themes we are going to build based on DE useflags
	use gnome && themes+=" tango"
	use kde && themes+=" oxygen"

	# list the extensions we are going to build by default
	extensions="
		--enable-ext-pdfimport
		--enable-ext-presenter-console
		--enable-ext-presenter-minimizer
	"

	# Things that do not have gentoo packages
	# hsqldb: requires just 1.8.0 not 1.8.1 which we don't ship at all
	# we should use in-system dmake: so far fails
	internal_libs+="
		--without-system-altlinuxhyph
		--without-system-hsqldb
		--without-system-lpsolve
		--without-system-mdds
	"

	# When building without java some things needs to be done
	# as internal libraries.
	if ! use java; then
		internal_libs+="
			--without-system-beanshell
			--without-system-lucene
			--without-system-saxon
		"
	else
		java_opts="
			--with-ant-home=${ANT_HOME}
			--with-jdk-home=$(java-config --jdk-home 2>/dev/null)
			--with-java-target-version=$(java-pkg_get-target)
			--with-jvm-path=${EPREFIX}/usr/$(get_libdir)/
			--with-beanshell-jar=$(java-pkg_getjar bsh bsh.jar)
			--with-lucene-core-jar=$(java-pkg_getjar lucene-2.9 lucene-core.jar)
			--with-lucene-analyzers-jar=$(java-pkg_getjar lucene-analyzers-2.3 lucene-analyzers.jar)
			--with-saxon-jar=$(java-pkg_getjar saxon saxon8.jar)
			--with-junit=$(java-pkg_getjar junit-4 junit.jar)
		"
	fi

	# TODO: create gentoo branding on the about/intro screens
	# --with-about-bitmap="${FILESDIR}/gentoo-about.png"
	# --with-intro-bitmap="${FILESDIR}/gentoo-intro.png"

	# system headers/libs/...: enforce using system packages
	#   only expections are mozilla and odbc/sane/xrender-header(s).
	#   for jars the exception is db.jar controlled by --with-system-db
	# --enable-unix-qstart-libpng: use libpng splashscreen that is faster
	# --disable-broffice: do not use brazillian brand just be uniform
	# --enable-cairo: ensure that cairo is always required
	# --disable-graphite: no package in gentoo
	# --enable-*-link: link to the library rather than just dlopen on runtime
	# --disable-fetch-external: prevent dowloading during compile phase
	# --disable-gnome-vfs: old gnome virtual fs support
	# --disable-kdeab: kde3 adressbook
	# --disable-kde: kde3 support
	# --disable-rpath: relative runtime path is not desired
	# --disable-static-gtk: ensure that gtk is linked dynamically
	# --disable-zenity: disable build icon
	# --with-extension-integration: enable any extension integration support
	# --with-{max-jobs,num-cpus}: ensuring parallel building
	# --without-{afms,fonts,myspell-dicts,ppsd}: prevent install of sys pkgs
	# --without-stlport: disable deprecated extensions framework
	econf \
		--with-system-headers \
		--with-system-libs \
		--with-system-jars \
		--with-system-db \
		--with-system-dicts \
		--enable-cairo \
		--enable-fontconfig \
		--enable-largefile \
		--enable-randr \
		--enable-randr-link \
		--enable-unix-qstart-libpng \
		--enable-Xaw \
		--enable-xrender-link \
		--disable-broffice \
		--disable-crashdump \
		--disable-dependency-tracking \
		--disable-epm \
		--disable-fetch-external \
		--disable-gnome-vfs \
		--disable-graphite \
		--disable-kdeab \
		--disable-kde \
		--disable-online-update \
		--disable-rpath \
		--disable-static-gtk \
		--disable-zenity \
		--with-alloc=system \
		--with-build-version="Gentoo official package" \
		--with-extension-integration \
		--with-external-dict-dir="${EPREFIX}/usr/share/myspell" \
		--with-external-hyph-dir="${EPREFIX}/usr/share/myspell" \
		--with-external-thes-dir="${EPREFIX}/usr/share/myspell" \
		--with-external-tar="${DISTDIR}" \
		--with-lang="${LINGUAS_OOO}" \
		--with-max-jobs=${jobs} \
		--with-num-cpus=${jobs} \
		--with-theme="${themes}" \
		--with-unix-wrapper=libreoffice \
		--with-vendor="Gentoo Foundation" \
		--with-x \
		--without-afms \
		--without-fonts \
		--without-myspell-dicts \
		--without-ppds \
		--without-stlport \
		$(use_enable binfilter) \
		$(use_enable cups) \
		$(use_enable dbus) \
		$(use_enable eds evolution2) \
		$(use_enable gnome gconf) \
		$(use_enable gnome gio) \
		$(use_enable gnome lockdown) \
		$(use_enable gstreamer) \
		$(use_enable gtk) \
		$(use_enable gtk systray) \
		$(use_enable java ext-scripting-beanshell) \
		$(use_enable kde kde4) \
		$(use_enable ldap) \
		$(use_enable mysql ext-mysql-connector) \
		$(use_enable nsplugin mozilla) \
		$(use_enable odk) \
		$(use_enable opengl) \
		$(use_enable pch) \
		$(use_enable python) \
		$(use_enable python ext-scripting-python) \
		$(use_enable webdav neon) \
		$(use_with java) \
		$(use_with java junit) \
		$(use_with ldap openldap) \
		$(use_with mysql system-mysql-cppconn) \
		$(use_with nsplugin system-mozilla libxul) \
		$(use_with offlinehelp helppack-integration) \
		$(use_with templates sun-templates) \
		${internal_libs} \
		${java_opts}
}

src_compile() {
	emake || die
}

src_install() {
	local SIZE desk app

	export PYTHONPATH=""

	emake DESTDIR="${D}" install || die

	# Fix the permissions for security reasons
	use prefix || chown -RP root:0 "${ED}"

	# Desktop files
	for i in *; do
		mv ${i}.desktop ${PN}-${i}.desktop
	done
	sed -i \
		-e s/libreoffice3.4/${PN}/g \
		-e s/libreoffice34/${PN}/g \
		"${ED}"/usr/$(get_libdir)/${PN}/share/xdg/*.desktop || die111
	use java || rm "${ED}"/usr/$(get_libdir)/${PN}/share/xdg/javafilter.desktop
	pushd "${ED}"/usr/$(get_libdir)/${PN}/share/xdg/ > /dev/null
	popd > /dev/null
	domenu "${ED}"/usr/$(get_libdir)/${PN}/share/xdg/*.desktop

	# install icons
	insinto /usr/share/icons/
	doins -r "${S}"/sysui/desktop/icons/hicolor

	# app icon names are too generic, have to make them unique
	for SIZE in 16 32 48 128 ; do
		cd "${ED}"/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		for app in base calc draw impress main math startcenter writer ; do
			mv ${app}.png ${PN}-${app}.png || die
		done
	done

	# install mime package
	dodir /usr/share/mime/packages
	cp sysui/*.pro/misc/${PN}/openoffice.org.xml \
		"${ED}"/usr/share/mime/packages/${PN}.xml

	# Install wrapper script
	sed -i -e s/LIBDIR/$(get_libdir)/g "${T}/wrapper.in" || die
	newbin "${T}/wrapper.in" ${PN} || die

	# Cleanup after playing
	rm "${ED}"/gid_Module_*

}

pkg_preinst() {
	# Cache updates - all handled by kde eclass for all environments
	kde4-base_pkg_preinst
}

pkg_postinst() {
	kde4-base_pkg_postinst

	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/libreoffice/program/soffice.bin
}

pkg_postrm() {
	kde4-base_pkg_postrm
}