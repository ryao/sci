# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
inherit distutils eutils

MY_PN="mslib"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MSMS library python extension module"
HOMEPAGE="http://mgltools.scripps.edu/downloads#msms"
#SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL${PV}/mgltools_source_${PV}.tar.gz"
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/mgltools_source_${PV}.tar.gz"

LICENSE="MGLTOOLS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/swig"

RESTRICT_PYTHON_ABIS="3.*"
S="${WORKDIR}"/${MY_P}

src_unpack() {
	tar xzpf "${DISTDIR}"/${A} mgltools_source_${PV}/MGLPACKS/${MY_P}.tar.gz
	tar xzpf mgltools_source_${PV}/MGLPACKS/${MY_P}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/build-with-linux-3.0.patch
	pushd "${S}"/lib >/dev/null
	# Set up symlinks for 3.x kernels
	for x in *inux2; do
		ln -s ${x} ${x%2}3
	done
	popd >/dev/null
}

pkg_postinst() {
	python_mod_optimize ${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup ${MY_PN}
}
