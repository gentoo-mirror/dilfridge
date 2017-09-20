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

RPC_ALL_IMPL=( sunrpc libtirpc ntirpc )

# @ECLASS-VARIABLE: RPC_COMPAT
# @DESCRIPTION:
# This variable contains a list of RPC implementations the package
# supports. It must be set before the `inherit' call; if not, the
# package is assumed to be compatible with all known implementations.
# Example:
# @CODE
# RPC_COMPAT=( sunrpc libtirpc ntirpc )
# @CODE
RPC_COMPAT=( "${RPC_COMPAT[@]:-${RPC_ALL_IMPL[@]}}" )

# @ECLASS-VARIABLE: RPC_REQUIRED
# @DESCRIPTION:
# Is rpc support required? Possible values are 'always' and 'optional'.
# This variable must be set before inheriting any eclasses. Defaults to 'always'
# If set to 'optional', a useflag 'rpc' is created.
RPC_REQUIRED="${RPC_REQUIRED:-always}"

local _rpc_rdepend=""
local _rpc_depend=""

for i in ${RPC_COMPAT[@]}; do
	case "${i}" in
		sunrpc)
			_rpc_depend+="sunrpc? ( elibc_glibc? ( <sys-libs/glibc-2.26[rpc] ) ) "
			_rpc_rdepend+="sunrpc? ( elibc_glibc? ( <sys-libs/glibc-2.26[rpc] ) ) "
			IUSE+="sunrpc "
			;;
		libtirpc)
			_rpc_depend+="libtirpc? ( net-libs/libtirpc virtual/pkgconfig ) "
			_rpc_rdepend+="libtirpc? ( net-libs/libtirpc ) "
			IUSE+="libtirpc "

			;;
		ntirpc)
			_rpc_depend+="ntirpc? ( net-libs/ntirpc virtual/pkgconfig ) "
			_rpc_rdepend+="ntirpc? ( net-libs/ntirpc ) "
			IUSE+="ntirpc "
			;;
		*)
			die "Unsupported RPC implementation ${i}"
			;;
	esac
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
esac

declare -A _rpc_seen
local _rpc_required="("
for word in ${RPC_COMPAT[@]}; do
        if [ ! "${_rpc_seen[$word]}" ]
        then
                _rpc_required+=" $word"
                seen[$word]=1
        fi
done
if [[ ${_rpc_required} != "(" ]]; then
		REQUIRED_USE="^^ ${_rpc_required} )"
fi

# @FUNCTION: rpc_configure
# @DESCRIPTION:
# Outputs a string useful for passing to a configure invocation. 
# In detail, "--with-rpc=x", where x is either sunrpc, libtirpc, or
# ntirpc.
rpc_configure() {
	local _rpc_configure
	use sunrpc && _rpc_configure="--with-rpc=sunrpc"
	use libtirpc && _rpc_configure="--with-rpc=libtirpc"
	use ntirpc && _rpc_configure="--with-rpc=ntirpc"
	echo ${_rpc_configure}
}

unset _rpc_rdepend
unset _rpc_depend
