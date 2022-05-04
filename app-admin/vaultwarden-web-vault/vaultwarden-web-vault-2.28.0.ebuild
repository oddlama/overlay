# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Web vault builds for vaultwarden"
HOMEPAGE="https://github.com/dani-garcia/bw_web_builds"
SRC_URI="https://github.com/dani-garcia/bw_web_builds/releases/download/v${PV}/bw_web_v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/web-vault"

src_install() {
	insinto /usr/share/vaultwarden-web-vault/htdocs
	doins -r *
}
