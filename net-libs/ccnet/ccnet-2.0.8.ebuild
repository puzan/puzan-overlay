# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils autotools python

DESCRIPTION="Networking library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="-demo client -server python cluster ldap"

DEPEND="=net-libs/libsearpc-${PV}
	>=dev-libs/glib-2.0
	>=dev-lang/vala-0.8
	app-admin/eselect-vala
	server? ( dev-db/libzdb )
	dev-util/pkgconfig"

RDEPEND=""

REQUIRED_USE="^^ ( client server )"

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf $(use_enable demo compile-demo) \
		$(use_enable server) \
		$(use_enable client) \
		$(use_enable python) \
		$(use_enable cluster) \
		$(use_enable ldap) \
		--enable-console \
		|| die "econf failed"

	# Fix problem with multitreading build
	MAKEOPTS="-j1"
}

src_install() {
	#Fix wrong prefix in libccnet.pc file
	sed -i 's/(DESTDIR)//' "${S}/libccnet.pc"

	emake DESTDIR="${D}" install
}
