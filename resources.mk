# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines the set of rules for a resource list


# This makefile is included for each component definition so clear out
# any variables used by this makefile
resource_spec      :=
spec_words         :=
resource_source    :=
resource_dest      :=
def_resource_file  :=
resource_alias     :=
dest_path          :=
resource_goal_list :=

define resource_file_rule

    $$(call debug_info,resource specified: $(1))

    resource_spec := $(1)
    spec_words    := $$(subst :, ,$$(resource_spec))
    ifneq ($$(words $$(spec_words)),2)
        $$(call def_error,invalid resource syntax: $$(resource_spec))
    endif

    resource_source := $$(word 1,$$(spec_words))
    resource_dest   := $$(word 2,$$(spec_words))
    ifeq ($$(resource_source),)
        $$(call def_error,invalid resource syntax: $$(resource_spec))
    endif
    ifeq ($$(resource_dest),)
        $$(call def_error,invalid resource syntax: $$(resource_spec))
    endif

    def_resource_file := $$(def_path)/$$(resource_source)
    resource_alias    := $$(resource_dest)

    dest_path := $$(dir $$(resource_output_path)/$$(resource_dest))

    resource_goal_list := $$(resource_alias) $$(resource_goal_list)
    directory_list     := $$(dest_path) $$(directory_list)

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
