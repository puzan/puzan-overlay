# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils autotools git-2 python

DESCRIPTION="Networking library for Seafile"
HOMEPAGE="http://www.seafile.com"
EGIT_REPO_URI="git://github.com/haiwen/ccnet.git"
S=${WORKDIR}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="demo client server python cluster ldap mysql"

DEPEND="net-libs/libsearpc
	>=dev-libs/glib-2.0
	>=dev-lang/vala-0.8
	dev-db/libzdb
	dev-util/pkgconfig"

RDEPEND=""

src_unpack() {
	git-2_src_unpack
}

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
		$(use_enable mysql) \
		--enable-console \
		|| die "econf failed"
}
