# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines settings for the cpp language


compile_command := $(if $(gcc_opt_use_clang),clang++,g++)

compiler_flag_list := -std=c++11 $(compiler_flag_list)
