# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for paperless"
ACCT_USER_ID=359
ACCT_USER_GROUPS=( paperless )
ACCT_USER_HOME=/var/lib/paperless
ACCT_USER_HOME_PERMS=0700
acct-user_add_deps
