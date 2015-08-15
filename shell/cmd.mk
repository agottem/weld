# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines cmd specific functionality used throughout weld


# Convert a native path name to a universal representation
path_to_universal = $(subst \,/,$(1))

# Convert a universtal path name to the native representation
path_to_native = $(subst /,\,$(1))

# Find all files of the specified name beneath the specified path
find_files = $(strip $(call path_to_universal,$(shell dir /B /S $(call path_to_native,$(1)/$(2)))))

# Windows doesn't support symlinking so soft and hard copy both
# make copies'
soft_copy = $(strip copy /V $(call path_to_native,$(1) $(2)) 1>NUL)
hard_copy = $(strip copy /V $(call path_to_native,$(1) $(2)) 1>NUL)

# Remove files which exist
remove_files  = $(strip $(if $(wildcard $(1)),del /Q /F $(call path_to_native,$(wildcard $(1))),))

# Create a directory tree
make_directory = $(strip $(if $(wildcard $(1)),,mkdir $(call path_to_native,$(1))))

# Print to stdout
print  = echo $(1)
