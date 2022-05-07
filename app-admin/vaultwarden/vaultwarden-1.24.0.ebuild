# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "
inherit git-r3 cargo systemd

DESCRIPTION="Vaultwarden - Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
EGIT_REPO_URI="https://github.com/dani-garcia/vaultwarden.git"
EGIT_COMMIT="${PV}"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql postgres sqlite"

REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND="
	acct-group/vaultwarden
	acct-user/vaultwarden
	>=app-admin/vaultwarden-web-vault-2.28.0
	>=dev-lang/rust-1.60[nightly]
	sqlite? ( dev-db/sqlite )
	dev-libs/openssl:0="
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack

	mkdir -p "${S}" || die

	pushd "${S}" > /dev/null || die
	CARGO_HOME="${ECARGO_HOME}" cargo fetch || die
	CARGO_HOME="${ECARGO_HOME}" cargo vendor "${ECARGO_VENDOR}" || die
	popd > /dev/null || die

	cargo_gen_config
}

src_configure() {
	myfeatures=(
		$(usev mysql)
		$(usex postgres postgresql '')
		$(usev sqlite)
	)
}

src_compile() {
	cargo_src_compile ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features
}

src_install() {
	cargo_src_install ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features

	einstalldocs

	# Install init.d and conf.d scripts
	newinitd "${FILESDIR}"/init vaultwarden
	newconfd "${FILESDIR}"/conf vaultwarden
	systemd_newunit "${FILESDIR}"/vaultwarden.service vaultwarden.service

	# Install /etc/vaultwarden.env
	insinto /etc
	newins .env.template vaultwarden.env
	fowners root:vaultwarden /etc/vaultwarden.env
	fperms 640 /etc/vaultwarden.env

	# Install launch wrapper
	exeinto /var/lib/vaultwarden
	doexe "${FILESDIR}"/vaultwarden

	# Keep data dir
	keepdir /var/lib/vaultwarden/data
	fowners vaultwarden:vaultwarden /var/lib/vaultwarden/data
	fperms 700 /var/lib/vaultwarden/data
}

src_test() {
	cargo_src_test ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features
}
