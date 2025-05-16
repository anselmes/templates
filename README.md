# Readme

```shell
# Copy the example environment file to .env
cp -f example.env .env
```

```shell
# Source the environment variables from .env and Zephyr environment script
source .env
source "${ZEPHYR_BASE}/zephyr-env.sh"
```

## Build

```shell
# Build the Zephyr project for the specified board and device tree overlay
west build -p -b"${ZEPHYR_BOARD}" -- -DDTC_OVERLAY_FILE="${ZEPHYR_BOARD_OVERLAY}"
```

## Flash

```shell
# Flash the compiled firmware to the board
west flash
```

---

Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
