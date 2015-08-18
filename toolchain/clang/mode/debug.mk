# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines settings for debug mode


compiler_flag_list := -O0 -g -fno-inline-functions $(compiler_flag_list)
