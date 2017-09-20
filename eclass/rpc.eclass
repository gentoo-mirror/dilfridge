# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rpc.eclass
# @MAINTAINER:
# toolchain@gentoo.org
# @BLURB: helper functions to depend on rpc implementations
# @DESCRIPTION:
# This eclass ...
# @EXAMPLE:
#
# @CODE
# inherit rpc
#
# @CODE

case ${EAPI:-0} in
	0|1)		die "EAPI=0 and EAPI=1 is not supported by ${ECLASS}.eclass." ;;
	2|3|4|5|6)	;;
	*)		die "${ECLASS}.eclass API in EAPI ${EAPI} not yet established."
esac

# @ECLASS-VARIABLE: RPC_COMPAT
# @DESCRIPTION:
# This variable contains a list of RPC implementations the package
# supports. It must be set before the `inherit' call; if not, the
# package is assumed to be compatible with all known implementations.
# Example (the default):
# @CODE
# RPC_COMPAT=( sunrpc libtirpc ntirpc )
# @CODE
: ${RPC_COMPAT:=( sunrpc libtirpc ntirpc )}

# @ECLASS-VARIABLE: RPC_REQUIRED
# @DESCRIPTION:
# Is rpc support required? Possible values are 'always' and 'optional'.
# This variable must be set before inheriting any eclasses. Defaults to 'always'
# If set to 'optional', a useflag 'rpc' is created.
RPC_REQUIRED="${RPC_REQUIRED:-always}"

# @ECLASS-VARIABLE: RPC_CONFIGURE
# @DESCRIPTION:
# Contains a string to supply to a configure call as argument; suitable if the
# reference autoconf snippet is used for patching. In detail, the content is
# '--with-rpc=x', where x is one of sunrpc, libtirpc, ntirpc, depending on the
# use-flag settings.

local _rpc_rdepend=""
local _rpc_depend=""

for i in "${RPC_COMPAT[@]}"; do
	case "${i}" in
		sunrpc)
			_rpc_depend+="sunrpc? ( elibc_glibc? ( <sys-libs/glibc-2.26[rpc] ) ) "
			_rpc_rdepend+="sunrpc? ( elibc_glibc? ( <sys-libs/glibc-2.26[rpc] ) ) "
			IUSE+="sunrpc "
			use sunrpc && RPC_CONFIGURE="--with-rpc=sunrpc"
			;;
		libtirpc)
			_rpc_depend+="libtirpc? ( net-libs/libtirpc virtual/pkgconfig ) "
			_rpc_rdepend+="libtirpc? ( net-libs/libtirpc ) "
			IUSE+="libtirpc "
			use libtirpc && RPC_CONFIGURE="--with-rpc=libtirpc"
			;;
		ntirpc)
			_rpc_depend+="ntirpc? ( net-libs/ntirpc virtual/pkgconfig ) "
			_rpc_rdepend+="ntirpc? ( net-libs/ntirpc ) "
			IUSE+="ntirpc "
			use ntirpc && RPC_CONFIGURE="--with-rpc=ntirpc"
			;;
		*)
			die "Unsupported RPC implementation ${i}"
			;;
	done
done

case "${RPC_REQUIRED}" in
	always)
		DEPEND=${_rpc_depend}
		RDEPEND=${_rpc_rdepend}
		;;
	optional)
		IUSE+="rpc "
		DEPEND="rpc? ( ${_rpc_depend} )"
		RDEPEND="rpc? ( ${_rpc_rdepend} )"
		;;
	*)
		die "Unsupported value for RPC_REQUIRED."
		;;
done

#REQUIRED_USE="^^ ( sunrpc libtirpc ntirpc )"

unset _rpc_rdepend
unset _rpc_depend
