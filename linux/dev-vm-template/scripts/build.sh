#!/bin/bash

# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
# SPDX-Licence-Identifier: GPL-3.0

set -euo pipefail

# This script automates the creation of a virtual machine image using a base Ubuntu cloud image
# and cloud-init configuration files. It performs the following steps:
# 1. Downloads the base Ubuntu image if it doesn't exist.
# 2. Validates the presence of required cloud-init configuration files.
# 3. Creates a seed ISO containing the cloud-init configuration.
# 4. Copies the base image to create a new QCOW2 image for the VM.

# Input arguments:
# $1 - Name of the output image (e.g., "devm")
# $2 - Name of the base Ubuntu cloud image (e.g., "jammy-server-cloudimg-amd64.img")
# $3 - Directory containing cloud-init configuration files (e.g., "cloudinit")

IMAGE_NAME="${1}"
UBUNTU_IMAGE="${2}"
CLOUDINIT_DIR="${3}"

# Step 1: Download the base Ubuntu image if it doesn't already exist
if [ ! -f "${UBUNTU_IMAGE}" ]; then
  echo "Downloading base image: ${UBUNTU_IMAGE}"
  curl -fsSLo "${UBUNTU_IMAGE}" "https://cloud-images.ubuntu.com/jammy/current/${UBUNTU_IMAGE}"
fi

# Step 2: Ensure the required cloud-init configuration files exist
if [ ! -f "$CLOUDINIT_DIR/user-data" ] || [ ! -f "$CLOUDINIT_DIR/meta-data" ]; then
  echo "Missing cloudinit/user-data or meta-data"
  exit 1
fi

# Step 3: Build the seed ISO containing the cloud-init configuration
echo "Creating seed ISO..."
genisoimage -output "${IMAGE_NAME}-seed.iso" \
  -volid cidata \
  -joliet -rock \
  "${CLOUDINIT_DIR}/user-data" "${CLOUDINIT_DIR}/meta-data"

# Step 4: Copy the base Ubuntu image to create a new QCOW2 image for the VM
cp "${UBUNTU_IMAGE}" "${IMAGE_NAME}.qcow2"

# Final output messages
echo "✅ Built image: ${IMAGE_NAME}.qcow2"
echo "➡  Use with: virt-install, qemu, or convert to UTM/VM"

# Optional: Convert the QCOW2 image to a raw image for UTM compatibility
# Uncomment the following lines if needed:
# qemu-img convert -O raw "${IMAGE_NAME}.qcow2" "${IMAGE_NAME}.img"
# echo "✅ UTM-compatible raw image: ${IMAGE_NAME}.img"
