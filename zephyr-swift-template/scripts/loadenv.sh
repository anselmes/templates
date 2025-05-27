#!/bin/bash

# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
# SPDX-Licence-Identifier: GPL-3.0

# loadenv.sh - Environment Setup Script
#
# This script loads all required environment variables and settings needed for
# developing Swift applications that target the Zephyr RTOS. It must be sourced
# (not executed) in your shell session before building or running your project.
#
# Usage:
#   source ./scripts/loadenv.sh
#   # or
#   . ./scripts/loadenv.sh

# Load Swift development environment variables and tools
# This includes paths to Swift compilers, libraries, and other required tools
. /usr/local/swiftly/env.sh

# Set up the Zephyr RTOS development environment
# This adds Zephyr tools to PATH and sets ZEPHYR_BASE and other required variables
. /opt/zephyrproject/zephyr/zephyr-env.sh

# Activate the Python virtual environment for Zephyr development
# This ensures python dependencies for Zephyr tools are available
. /opt/zephyrproject/.venv/bin/activate

# The development environment is now prepared for building Swift applications
# that target Zephyr RTOS
