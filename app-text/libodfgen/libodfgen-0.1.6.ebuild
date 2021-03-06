# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="git://git.code.sf.net/p/libwpd/libodfgen"
[[ ${PV} == 9999 ]] && inherit autotools git-r3

DESCRIPTION="Library to generate ODF documents from libwpd and libwpg"
HOMEPAGE="http://libwpd.sf.net"
[[ ${PV} == 9999 ]] || SRC_URI="mirror://sourceforge/libwpd/${P}.tar.xz"

LICENSE="|| ( LGPL-2.1 MPL-2.0 )"
SLOT="0"

[[ ${PV} == 9999 ]] || \
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 x86 ~amd64-linux ~x86-linux"

IUSE="doc"

RDEPEND="
	dev-libs/librevenge
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_prepare() {
	default
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--disable-werror \
		--with-sharedptr=c++11 \
		$(use_with doc docs)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
