# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This is the entry point into the weld build system.  This file should
# be included by a project's root level makefile'


# Weld doesn't use implicit rules so turn them off
.SUFFIXES :


# Figure out the path of this makefile
weld_makefile := $(lastword $(MAKEFILE_LIST))
weld_path     := $(dir $(weld_makefile))


ifneq ($(config_file),)
    include $(config_file)
endif

# Set the defaults
include $(weld_path)/config.mk

# Verify the config file has set all the necessary variables
ifeq ($(source_path),)
    $(error csdk_path is not set)
endif

ifeq ($(build_path),)
    $(error build_path is not set)
endif

ifeq ($(arch),)
    $(error arch is not set)
endif

ifeq ($(mode),)
    $(error mode is not set)
endif

ifeq ($(shell_name),)
    $(error shell_name is not set)
endif

ifeq ($(platform),)
    $(error platform is not set)
endif

ifeq ($(c_toolchain),)
    $(error c_toolchain is not set)
endif


# Set derived path values
include $(weld_path)/paths.mk

# Include shell functions and standard utility functions
include $(weld_path)/shell/$(shell_name).mk
include $(weld_path)/utils.mk

# Discover and include all the specified component definitions found
# for this project
include $(weld_path)/def.mk
include $(weld_path)/disc.mk


# Define the top level targets
.DEFAULT_GOAL := build


.PHONY : build
build : $(build_target_list)

.PHONE : headers
headers : $(headers_target_list)

.PHONY : clean
clean : $(clean_target_list)

.PHONE : clean_headers
clean_headers : $(clean_headers_target_list)

$(sort $(directory_list)) :
	$(call make_directory,$@)
