# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile defines the rule to expand for each component
# definition file found


define def_file_rule

    # Clear out all possible variables a component definition file
    # may define
    def_file            :=
    def_path            :=
    def_deps            :=
    def_include_subdir  :=
    def_source_subdir   :=
    def_resource_subdir :=
    name                :=
    type                :=
    lang                :=
    header_list         :=
    resource_list       :=
    source_list         :=
    definition_list     :=
    source_lib_list     :=
    lib_list            :=
    lib_path_list       :=
    include_path_list   :=
    compiler_flag_list  :=
    link_flag_list      :=


    $$(call debug_info,including def: $(1))

    def_file := $(1)
    def_path := $$(call def_file_to_root_path,$$(def_file))
    def_deps := $$(def_file) $$(config_file) $$(def_deps)


    ifeq ($$(def_include_subdir),)
        def_include_subdir := $$(include_subdir)
    endif

    ifeq ($$(def_source_subdir),)
        def_source_subdir := $$(source_subdir)
    endif

    ifeq ($$(def_resource_subdir),)
        def_resource_subdir := $$(resource_subdir)
    endif


    # Include the found component definition file
    include $$(def_file)

    # Custom component definition files might not bother with a name so skip the below stuff if
    # that's the case'
    ifneq ($$(name),)
        ifneq ($$(filter $$(name), $$(build_target_list)),)
            $$(call def_error,duplicate component name used here: $$($$(name).def_file))
        endif

        $$(name).def_file := $$(def_file)

        # Include the config file again after including the definition file.
        # This way a config file could specify component-specific settings
        include $$(config_file)


        #  If a header list was specified, include header rules
        ifneq ($$(header_list),)
            include $$(weld_path)/headers.mk
        endif

        # If a resource list was specified, include resourcerules
        ifneq ($$(resource_list),)
            include $$(weld_path)/resources.mk
        endif

        # If the type is set to bin or lib include the compilation rules for the
        # specified language
        ifneq ($$(filter bin lib,$$(type)),)
            include $$(weld_path)/lang/$$(lang).mk
        endif

        # Add the found component to the standard set of build targets
        build_target_list         := $$(name) $$(build_target_list)
        headers_target_list       := $$(name)_headers $$(headers_target_list)
        clean_target_list         := clean_$$(name) $$(clean_target_list)
        clean_headers_target_list := clean_$$(name)_headers


        # Declare default targets for this component.  Various component rules
        # may add build steps as dependencies to these targets
        .PHONY : $$(name)_headers
        $$(name)_headers : $$(name)_def_headers
        $$(name)_headers :

        .PHONY : $$(name)_def_headers
        $$(name)_def_headers :

        .PHONY : clean_$$(name)_headers
        clean_$$(name)_headers : clean_$$(name)_def_headers
        clean_$$(name)_headers :

        .PHONY : clean_$$(name)_def_headers
        clean_$$(name)_def_headers :

        .PHONY : $$(name)_compile
        $$(name)_compile : $$(name)_def_compile
        $$(name)_compile :

        .PHONY : $$(name)_def_compile
        $$(name)_def_compile :

        .PHONY : clean_$$(name)_compile
        clean_$$(name)_compile : clean_$$(name)_def_compile
        clean_$$(name)_compile :

        .PHONY : clean_$$(name)_def_compile
        clean_$$(name)_def_compile :

        .PHONY : $$(name)_resources
        $$(name)_resources : $$(name)_def_resources
        $$(name)_resources :

        .PHONY : $$(name)_def_resources
        $$(name)_def_resources :

        .PHONY : clean_$$(name)_resources
        clean_$$(name)_resources : clean_$$(name)_def_resources
        clean_$$(name)_resources :

        .PHONY : clean_$$(name)_def_resources
        clean_$$(name)_def_resources :

        # Define the "make <name>" target for the component.  This target
        # should build the entire component
        .PHONY : $$(name)
        $$(name) : $$(name)_headers
        $$(name) : $$(name)_compile
        $$(name) : $$(name)_resources
        $$(name) :

        .PHONY : clean_$$(name)
        clean_$$(name) : clean_$$(name)_headers
        clean_$$(name) : clean_$$(name)_compile
        clean_$$(name) : clean_$$(name)_resources
        clean_$$(name) :
    endif

endef
