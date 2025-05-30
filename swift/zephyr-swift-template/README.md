# Zephyr Template (Swift)

A template for developing Zephyr RTOS applications using Swift.

## Getting Started

1. **Clone the repository:**

   ```shell
   git clone <repo-url>
   cd zephyr-swift-template
   ```

2. **Set up environment variables:**

   ```shell
   cp -f example.env .env
   source .env
   source ./scripts/loadenv.sh
   ```

3. **Install dependencies:**

   - Ensure you have [Zephyr SDK](https://docs.zephyrproject.org/latest/develop/getting_started/index.html#install-the-zephyr-sdk) and [west](https://docs.zephyrproject.org/latest/develop/west/index.html) installed.
   - Install Swift toolchain if not already available.

## Build

Build the Zephyr project for your board:

```shell
west build -p
```

## Flash

Flash the compiled firmware to your board:

```shell
west flash
```

## License

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
