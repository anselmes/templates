# Linux Kernel Module (Rust)

A template for building Linux Kernel Modules (LKMs) in Rust.

## Features

- Boilerplate setup for Rust-based LKMs
- Example module code
- Build scripts and instructions

## Getting Started

1. **Clone the repository:**

    ```shell
    git clone https://github.com/yourusername/lkm-rust-template.git
    cd lkm-rust-template
    ```

2. **Build the module:**

    ```shell
    make
    ```

3. **Insert the module:**

    ```shell
    sudo insmod target/lkm_rust_template.ko
    ```

4. **Check kernel logs:**

    ```shell
    dmesg | tail
    ```

## Requirements

- Rust toolchain (nightly)
- Linux kernel headers
- `make`, `gcc`

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
