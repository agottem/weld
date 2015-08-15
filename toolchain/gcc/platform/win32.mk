# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines settings for the windows platform


ifeq ($(type), bin)
    compile_goal      := $(patsubst $(output_path)/%,%,$(bin_output_path))/$(name).exe
    compile_goal_path := $(output_path)

    link_flag_list := -mwindows $(link_flag_list)
else
    compile_goal      := lib$(name).a
    compile_goal_path := $(lib_output_path)
endif

definition_list := WIN32                 \
                   UNICODE               \
                   WINVER=0x0400         \
                   _WIN32_WINNT=0x0400   \
                   _WIN32_WINDOWS=0x0400 \
                   _WIN32_IE=0x0500      \
                   $(definition_list)
