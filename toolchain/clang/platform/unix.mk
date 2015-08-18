# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines settings for the unix platform (linux, bsd, etc)


ifeq ($(type), bin)
    compile_goal      := $(patsubst $(output_path)/%,%,$(bin_output_path))/$(name)
    compile_goal_path := $(output_path)
else
    compile_goal      := lib$(name).a
    compile_goal_path := $(lib_output_path)
endif

ifeq ($(unix_flavor), bsd)
    definition_list := _BSD_SOURCE $(definition_list)
else ifeq ($(unix_flavor), linux)
    definition_list := _XOPEN_SOURCE=700 _BSD_SOURCE $(definition_list)
endif
