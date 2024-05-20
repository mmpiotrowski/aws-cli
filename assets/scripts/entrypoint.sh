#!/bin/bash

set -eu

cd $(dirname "$0")

# user uid/gid fix
./user_uid_gid_fix.sh

# return to workdir
cd - 1>/dev/null

# exec entrypoint as a user
su -c "$*" user
