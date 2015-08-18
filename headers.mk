# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines the set of rules for a header list


# This makefile is included for each component definition so clear out
# any variables used by this makefile
def_header_path        :=
def_header_output_path :=
header_file            :=
def_header_file        :=
header_alias           :=
dest_path              :=
header_goal_list       :=


ifneq ($(call list_contains_char,$(header_list),/),)
    $(call def_error,header_list must contain only the header file name and the file must live in the components include directory)
endif


# Figure out the include path for this component definition
def_header_path        := $(def_path)/$(def_include_subdir)
def_header_output_path := $(header_output_path)/$(name)

define header_file_rule

    $$(call debug_info,header specified: $(1))

    header_file     := $(1)
    def_header_file := $$(def_header_path)/$$(header_file)
    header_alias    := $$(name)/$$(header_file)

    header_goal_list := $$(header_alias) $$(header_goal_list)

    directory_list := $$(dest_path) $$(directory_list)

    # Define an alias for the header file so the user can do
    # "make name/header.h" on the command line
    vpath $$(header_alias) $$(header_output_path)

    # Set the target specific variables and dependencies for this header
    $$(header_alias) : header_path     := $$(header_path)
    $$(header_alias) : def_header_file := $$(def_header_file)
    $$(header_alias) : header_alias    := $$(header_alias)
    $$(header_alias) : $$(def_deps)
    $$(header_alias) : $$(def_header_file)

endef


# Expand the header file rule for each header specified
$(foreach file,$(header_list),$(eval $(call header_file_rule,$(file))))

# Add the output header directory to the list of directories we need to build
directory_list := $(def_header_output_path) $(directory_list)


# Add the list of header goals as a dependency of the component definition's
# headers target
$(name)_def_headers : $(header_goal_list)

# Define the actual recipe for a header
$(header_goal_list) : | $(def_header_output_path)
	$(call print_progress,$(header_alias))
	$(call soft_copy,$(def_header_file),$(header_output_path)/$(header_alias))

.PHONY : clean_$(name)_def_headers
clean_$(name)_def_headers : header_output_path := $(header_output_path)
clean_$(name)_def_headers : header_goal_list   := $(header_goal_list)
clean_$(name)_def_headers :
	$(call print_progress,$@)
	$(call remove_files,$(addprefix $(header_output_path)/,$(header_goal_list)))
