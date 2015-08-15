# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This make file derives all the necessary paths the weld build will
# require
def_file_name := def.mk

output_path          := $(build_path)/$(platform)/$(arch)/$(mode)
bin_output_path      := $(output_path)/bin
lib_output_path      := $(output_path)/lib
obj_output_path      := $(output_path)/obj
header_output_path   := $(output_path)/include
resource_output_path := $(output_path)/bin
