# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines sh specific functionality used throughout weld


# Convert a native path name to a universal representation
path_to_universal = $(1)

# Convert a universtal path name to the native representation
path_to_native = $(1)

# Find all files of the specified name beneath the specified path
find_files = $(strip $(call path_to_universal,$(shell find $(call path_to_native,$(1)) -name $(call path_to_native,$(2)))))

# Create a symlink to a file (requires passing --check-symlink-times on make command line)
# soft_copy = $(strip ln -s -f $(call path_to_native,$(abspath $(1)) $(abspath $(2))))
soft_copy = $(strip cp $(call path_to_native,$(1) $(2)))

# Make an actual copy of a file
hard_copy = $(strip cp $(call path_to_native,$(1) $(2)))

# Remove files which exist
remove_files = $(strip $(if $(wildcard $(1)),rm -f $(call path_to_native,$(wildcard $(1))),))

# Create a directory tree
make_directory = $(strip $(if $(wildcard $(1)),,mkdir -p $(call path_to_native,$(1))))

# Print to stdout
print = echo $(1)
