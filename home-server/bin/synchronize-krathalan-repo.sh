#!/usr/bin/env sh
#
# Description: Simple sh script to synchronize /home/builder/.local/share/krack/pkgcache
#              with reverse proxy nginx pacman cache at /var/lib/nginx-pacman-cache/krathalan/os/x86_64
#
# Homepage: https://github.com/krathalan/miscellaneous-scripts
#
# Copyright (C) 2020 Hunter Peavey
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# -----------------------------------------
# -------------- Guidelines ---------------
# -----------------------------------------

# This script follows the Google Shell Style Guide:
# https://google.github.io/styleguide/shell.xml

# This script uses shellcheck: https://www.shellcheck.net/

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eu # (Eo pipefail) is Bash only!
# set -Eeuo pipefail

# -----------------------------------------
# ----------- Program variables -----------
# -----------------------------------------

# Other
KRACK_PKGCACHE_DIR="/home/builder/.local/share/krack/pkgcache"
PACMAN_CACHE_DIR="/var/lib/nginx-pacman-cache/krathalan/os/x86_64"

# -----------------------------------------
# ---------------- Script -----------------
# -----------------------------------------

printf "Synchronizing folders...\n"
rsync -a --delete "${KRACK_PKGCACHE_DIR}/" "${PACMAN_CACHE_DIR}"
printf "\nDone. Setting all packages to be owned by root..."
chown root:root "${PACMAN_CACHE_DIR}"/*
printf "\nDone. Synchronization successful.\n"
