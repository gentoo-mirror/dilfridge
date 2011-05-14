# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit base eutils multilib

DESCRIPTION="NVIDIA CUDA Performance Primitives (NPP) library"
HOMEPAGE="http://developer.nvidia.com/cuda"

RESTRICT="binchecks mirror"

CUDA_V=${PV//_/-}
DIR_V=${CUDA_V//./_}
DIR_V=${DIR_V//beta/Beta}

BASE_URI="http://developer.download.nvidia.com/compute/cuda/${DIR_V}_prod/toolkit"
SRC_URI="amd64? ( ${BASE_URI}/npp_${CUDA_V}.16_linux_64.tar.gz )
	x86? ( ${BASE_URI}/npp_${CUDA_V}.16_linux_32.tar.gz )"

LICENSE="NVIDIA-NPP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="~dev-util/nvidia-cuda-toolkit-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SDK"

PATCHES=( "${FILESDIR}/${P}-asneeded.patch" )

src_compile() {
	use examples && CUDA_INSTALL_PATH=/opt/cuda emake
}

src_install() {
	if use doc ; then
		dodoc common/npp/doc/NPP_Library_*.pdf
		dohtml common/npp/doc/html/*
	fi

	local DEST=/opt/cuda

	into ${DEST}
	dolib common/npp/lib/*

	insinto ${DEST}/include
	doins common/npp/include/*.h

	if use examples ; then
		dobin samples/binarySegmentation/binarySegmentation
		dobin samples/boxFilter/boxFilter
		dobin samples/freeImageInterop/freeImageInterop
		dobin samples/histEqualization/histEqualization
	fi
}
