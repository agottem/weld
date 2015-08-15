# Copyright 2015 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Weld license.  Please consult the file "WELD_LICENSE" for
# details.

# This makefile discovers all the component definition files in a weld
# project and expands a set of rules for each found component


# If the user hasn't specified a predefined list of component definition
# files go ahead and discover them
ifeq ($(def_file_list),)

    def_file_list := $(call find_files,$(source_path),$(def_file_name))

endif


# Expand a component definition rule for each found component
$(foreach file,$(def_file_list),$(eval $(call def_file_rule,$(file))))
