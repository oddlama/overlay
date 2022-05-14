# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Send push notifications to your phone or desktop using PUT/POST"
HOMEPAGE="https://github.com/binwiederhier/ntfy"
SRC_URI="https://github.com/binwiederhier/ntfy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+web"
RESTRICT="network-sandbox"

DEPEND="
	acct-group/ntfy
	acct-user/ntfy
	dev-db/sqlite"
BDEPEND="
	web? ( net-libs/nodejs )
	>=dev-lang/go-1.18"
RDEPEND="${DEPEND}"

src_compile() {
	# Build web component, or create dummy files if web is not enabled.
	mkdir -p server/docs server/site
	if use web; then
		emake web
	else
		touch server/docs/index.html server/site/app.html
	fi

	# Build the server/client cli
	MY_LDFLAGS="-linkmode=external -extldflags=-static -s -w -X main.version=$PV -X main.commit=release -X main.date="
	export CGO_ENABLED=1
	ego build \
		-ldflags "$MY_LDFLAGS" \
		-tags sqlite_omit_load_extension,osusergo,netgo \
		-o "bin/ntfy"
}

src_install() {
	dobin bin/ntfy
	keepdir /var/cache/ntfy

	# Install service files
	systemd_dounit "${FILESDIR}"/ntfy.service
	systemd_dounit "${FILESDIR}"/ntfy-client.service
}
