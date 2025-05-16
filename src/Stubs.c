// SPDX-Licence-Identifier: GPL-3.0

/**
 * @file Stubs.c
 * @brief Stub implementations for missing C library functions in Zephyr SDK.
 *
 * This file provides stub implementations for functions required by Embedded Swift
 * that are not available in the Zephyr SDK's C libraries.
 */

#include <stdlib.h>
#include <errno.h>

/**
 * @brief Allocates memory with the specified alignment.
 *
 * This is a forward declaration for aligned_alloc, which allocates size bytes of uninitialized storage whose alignment is specified by alignment.
 * This function is required for the stub implementation of posix_memalign.
 *
 * @param alignment The alignment value, which must be a power of two and a multiple of sizeof(void *).
 * @param size      The size of the memory block to allocate.
 * @return          A pointer to the allocated memory, or NULL if the allocation fails.
 */
void *aligned_alloc(size_t alignment, size_t size);

/**
 * @brief Allocates memory with the specified alignment using posix_memalign interface.
 *
 * This function implements posix_memalign by forwarding the allocation request to aligned_alloc.
 * It is provided as a stub for environments where posix_memalign is not available, such as the Zephyr SDK.
 *
 * @param[out] memptr    Pointer to the allocated memory block (output parameter).
 * @param[in]  alignment The alignment value, which must be a power of two and a multiple of sizeof(void *).
 * @param[in]  size      The size of the memory block to allocate.
 *
 * @return 0 on successful allocation, or an error code (errno) on failure.
 */
int posix_memalign(void **memptr, const size_t alignment, const size_t size)
{
  // Attempt to allocate memory with the specified alignment and size
  void *p = aligned_alloc(alignment, size);

  if (p)
  {
    // Allocation succeeded, set the output pointer and return success
    *memptr = p;
    return 0;
  }

  // Allocation failed, return the error code stored in errno
  return errno;
}
