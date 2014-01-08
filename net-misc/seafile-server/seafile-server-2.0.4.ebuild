# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Seafile Server"
HOMEPAGE="http://www.seafile.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=net-misc/seafile-2.0.6[server]
	=net-libs/libsearpc-1.1.0
	=net-libs/ccnet-1.3.9
	=net-misc/seahub-2.0.4"

RDEPEND=""
