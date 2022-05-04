# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for vaultwarden"
ACCT_USER_ID=368
ACCT_USER_GROUPS=( vaultwarden )
ACCT_USER_HOME=/var/lib/vaultwarden
ACCT_USER_HOME_PERMS=0700
acct-user_add_deps
