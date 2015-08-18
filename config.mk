# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# Define default config options


source_path     ?= .
build_path      ?= ./build
include_subdir  ?= include
source_subdir   ?= source
resource_subdir ?= resource
arch            ?= amd64
mode            ?= debug

platform ?= $(if $(WINDIR),win32,unix)
ifeq ($(platform),win32)
    shell_name ?= cmd
else
    shell_name ?= sh

    OS := $(shell uname)
    ifeq ($(OS),Linux)
        unix_flavor ?= linux
        c_toolchain ?= gcc
    else ifeq ($(OS),Darwin)
        unix_flavor ?= darwin
        c_toolchain ?= clang
    endif
endif

# If the toolchain wasn't set by the above conditions default it to gcc
c_toolchain ?= gcc
