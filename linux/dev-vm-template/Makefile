# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
# SPDX-Licence-Identifier: GPL-3.0

# Name of the output image file
IMAGE_NAME := devm

# Name of the Ubuntu cloud image to be used as a base
UBUNTU_CLOUD_IMAGE := jammy-server-cloudimg-amd64.img

# Directory containing cloud-init configuration files
CLOUDINIT_DIR := cloudinit

# Path to the build script that performs the VM creation
BUILD_SCRIPT := ./scripts/build.sh

# Declare phony targets to avoid conflicts with files of the same name
.PHONY: all clean

# Default target: Builds the virtual machine image
# This target runs the build script with the specified parameters:
# - IMAGE_NAME: Name of the output image
# - UBUNTU_CLOUD_IMAGE: Base Ubuntu cloud image
# - CLOUDINIT_DIR: Directory with cloud-init configuration
all: $(BUILD_SCRIPT)
	$(BUILD_SCRIPT) $(IMAGE_NAME) $(UBUNTU_CLOUD_IMAGE) $(CLOUDINIT_DIR)

# Clean target: Removes generated files
# Deletes the QCOW2 image and seed ISO files created during the build process
clean:
	rm -f $(IMAGE_NAME).qcow2
	rm -f $(IMAGE_NAME)-seed.iso
