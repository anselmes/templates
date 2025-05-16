// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

/**
 * @file BridgingHeader.h
 * @brief Common header for Zephyr and Embedded Swift integration.
 *
 * This header includes project configuration and Zephyr kernel, device, and GPIO APIs,
 * and declares utility functions for GPIO access used across the project.
 */

#pragma once

// Project configuration header
#include <autoconf.h>

// Zephyr kernel APIs
#include <zephyr/kernel.h>
