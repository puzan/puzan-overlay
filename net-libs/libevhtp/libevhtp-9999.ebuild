# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit eutils cmake-utils git-2

DESCRIPTION="Flexible replacement for libevent's httpd API"
HOMEPAGE="https://github.com/ellzey/libevhtp/"
EGIT_REPO_URI="git://github.com/ellzey/libevhtp.git"
S=${WORKDIR}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-libs/libevent-2"

RDEPEND=""

src_unpack() {
	git-2_src_unpack
}
