# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines the set of rules for a resource list


# This makefile is included for each component definition so clear out
# any variables used by this makefile
def_resource_path  :=
resource_file      :=
def_resource_file  :=
resource_alias     :=
dest_path          :=
resource_goal_list :=


# Figure out the resource path for this component definition
def_resource_path := $(def_path)/$(def_resource_subdir)

define resource_file_rule

    $$(call debug_info,resource specified: $(1))

    resource_file     := $(1)
    def_resource_file := $$(def_resource_path)/$$(resource_file)
    resource_alias    := $$(resource_file)

    dest_path := $$(dir $$(resource_output_path)/$$(resource_file))

    resource_goal_list := $$(resource_alias) $$(resource_goal_list)

    directory_list := $$(dest_path) $$(directory_list)

    # Define an alias for the resource file so the user can do
    # "make path/to/resource" on the command line
    vpath $$(resource_alias) $$(resource_output_path)

    # Set the target specific variables and dependencies for this resource
    $$(resource_alias) : resource_output_path := $$(resource_output_path)
    $$(resource_alias) : def_resource_file    := $$(def_resource_file)
    $$(resource_alias) : resource_alias       := $$(resource_alias)
    $$(resource_alias) : $$(def_deps)
    $$(resource_alias) : $$(def_resource_file)
    $$(resource_alias) : | $$(dest_path)

endef


# Expand the resource rule for each resource specified
$(foreach file,$(resource_list),$(eval $(call resource_file_rule,$(file))))


# Add the list of resource goals as a dependency of the component definition's
# headers target
$(name)_def_resources : $(resource_goal_list)

# Define the actual recipe for a resource
$(resource_goal_list) :
	$(call print_progress,$(resource_alias))
	$(call soft_copy,$(def_resource_file),$(resource_output_path)/$(resource_alias))

.PHONY : clean_$(name)_resources
clean_$(name)_resources : resource_output_path := $(resource_output_path)
clean_$(name)_resources : resource_goal_list   := $(resource_goal_list)
clean_$(name)_resources :
	$(call print_progress,$@)
	$(call remove_files,$(addprefix $(resource_output_path)/,$(resource_goal_list)))
