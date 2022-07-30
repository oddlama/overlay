# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="A community-supported supercharged version of paperless: scan, index and archive all your physical documents"
HOMEPAGE="https://github.com/paperless-ngx/paperless-ngx"
SRC_URI="https://github.com/paperless-ngx/paperless-ngx/releases/download/v${PV}/paperless-ngx-v${PV}.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
IUSE="+ocr"

DEPEND="
	acct-group/paperless
	acct-user/paperless
	www-servers/gunicorn
	app-crypt/gnupg
	media-gfx/imagemagick
	media-gfx/optipng
	app-text/poppler[utils]
	media-libs/jbig2enc
	ocr? ( app-text/OCRmyPDF )
"
RDEPEND="${DEPEND}"

src_install() {
	einstalldocs

	# Install service files
	systemd_newunit "${FILESDIR}"/paperless-webserver.service paperless-webserver.service
	systemd_newunit "${FILESDIR}"/paperless-scheduler.service paperless-scheduler.service
	systemd_newunit "${FILESDIR}"/paperless-consumer.service paperless-consumer.service
	systemd_newunit "${FILESDIR}"/paperless.target paperless.target

	# Install paperless files
	insinto /usr/share/paperless
	doins -r docs src static gunicorn.conf.py requirements.txt

	insinto /etc
	doins paperless.conf
	fowners root:paperless /etc/paperless.conf
	fperms 640 /etc/paperless.conf

	# Keep data dir
	keepdir /var/lib/paperless/data
	fowners paperless:paperless /var/lib/paperless/data
	fperms 700 /var/lib/paperless/data
}

pkg_postinst() {
	einfo "Before you can use paperless, you have to setup the python dependencies and"
	einfo "initialize the database. Execute the following commands as the paperless user."
	einfo "If you are updating from a previous version, you should update the dependencies"
	einfo "and re-run the migrate command."
	einfo ""
	einfo "  # Create virtual environment"
	einfo "  python -m venv /var/lib/paperless/venv"
	einfo ""
	einfo "  # Install dependencies"
	einfo "  /var/lib/paperless/venv/bin/pip install -r /usr/share/paperless/requirements.txt"
	einfo ""
	einfo "  # Initialize database"
	einfo "  cd /usr/share/paperless/src"
	einfo "  /var/lib/paperless/venv/bin/python manage.py migrate"
	einfo ""
	einfo "  # Create superuser"
	einfo "  /var/lib/paperless/venv/bin/python manage.py createsuperuser"
}
