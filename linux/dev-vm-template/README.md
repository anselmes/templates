# Dev VM Template (Ubuntu)

This repository provides a template for creating a development virtual machine (VM) image using Ubuntu cloud images and cloud-init. The VM is preconfigured with FRR (Free Range Routing), WireGuard, and Bind9 DNS server.

## Features

- **FRR**: A routing protocol suite for dynamic routing.
- **WireGuard**: A modern VPN solution for secure networking.
- **Bind9**: A DNS server for managing domain name resolution.
- **Cloud-Init**: Automates VM configuration during the first boot.

## Prerequisites

- **Dependencies**:
  - `curl`
  - `dnsutils`
  - `genisoimage`
  - `iptables-persistent`
  - `qemu`
  - `wireguard-tools`
- Ensure these tools are installed on your system before proceeding.

## Usage

### Build the VM Image

You can build the VM image and seed ISO using `make` or the provided script:

```shell
# Build the cloud image and seed ISO
make
# or
./scripts/build.sh devm jammy-server-cloudimg-amd64.img cloudinit
```

### Output Files

After running the build process, you will get the following files:

- `devm.qcow2`: The VM disk image.
- `devm-seed.iso`: The seed ISO containing cloud-init configuration.

### Run the VM

Use the following command to run the VM with QEMU:

```shell
qemu-system-x86_64 \
  -m 2048 -smp 2 \
  -drive file=devm.qcow2,format=qcow2 \
  -cdrom devm-seed.iso \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0
```

This command:

- Allocates 2 GB of memory and 2 CPU cores to the VM.
- Uses the generated QCOW2 image as the primary disk.
- Mounts the seed ISO for cloud-init configuration.
- Forwards port `2222` on the host to port `22` on the VM for SSH access.

### Access the VM

Once the VM is running, you can SSH into it using:

```shell
ssh -p 2222 <username>@localhost
```

Replace `<username>` with the default user configured in the cloud-init `user-data` file.

## Customization

### Cloud-Init Configuration

The cloud-init configuration files are located in the `cloudinit` directory:

- `user-data`: Contains system configuration, package installation, and custom scripts.
- `meta-data`: Provides instance-specific metadata such as hostname and instance ID.

You can modify these files to customize the VM's behavior during its first boot.

### Build Script

The build process is automated using the `scripts/build.sh` script. It performs the following steps:

1. Downloads the base Ubuntu cloud image if it doesn't exist.
2. Validates the presence of required cloud-init configuration files.
3. Creates a seed ISO containing the cloud-init configuration.
4. Copies the base image to create a new QCOW2 image for the VM.

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
