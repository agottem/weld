# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# Define default config options


source_path     ?= .
build_path      ?= ./build/out
include_subdir  ?= include
source_subdir   ?= source
resource_subdir ?= resource
arch            ?= amd64
mode            ?= debug
platform        ?= $(if $(WINDIR),win32,unix)
shell_name      ?= $(if $(WINDIR),cmd,sh)
c_toolchain     ?= gcc

ifeq ($(platform),unix)
    os := $(shell uname)
    ifeq ($(os),Linux)
        unix_flavor ?= linux
    else ifeq ($(os),Darwin)
        unix_flavor ?= darwin
        gcc_opt_use_clang ?= 1
    else ifeq ($(os),FreeBSD)
        unix_flavor ?= bsd
    endif
endif
