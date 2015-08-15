# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines how to construct compilation rules for c
# component definitions.  Since c is vastly superior to cpp,
# cpp component definitions will also include this file.


# Include the compile rules for c component definitions.
include $(weld_path)/toolchain/$(c_toolchain)/compile.mk
