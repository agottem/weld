# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines settings for release mode


compiler_flag_list := -O3 $(compiler_flag_list)

ifeq ($(type), bin)
    link_flag_list := -Wl,-O,1 $(link_flag_list)
endif
