# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines utility functions used throughout weld


# Print only if the user specified "show_progress=1"
print_progress = $(if $(show_progress),@$(call print,$(1)),)

# Print only if the user specified "debug_weld=1"
debug_info = $(if $(debug_weld),$(info debug-weld: $(1)),)

# Print an component definition related error message and stop the build
def_error = $(error $(def_file): $(1))

# Convert a component definition file to the components root path
def_file_to_root_path = $(patsubst %/$(def_file_name),%,$(1))

# Check if any values in a list contain a specific character
list_contains_char = $(if $(filter-out $(words $(1)) 0, $(words $(subst $(2), ,$(1)))),1,)
