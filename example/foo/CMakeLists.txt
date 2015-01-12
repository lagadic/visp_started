#############################################################################
#
# Description:
# CMakeList to build an executable
#
# Author:
# Fabien Spindler
#
##############################################################################

# SOURCE variable corresponds to the list of all the sources to build binaries.
# The generate binary comes by removing the .cpp extension to
# the source name.
#
# If you want to add/remove a source, modify here
set (SOURCE
  foo.cpp
)

# rule for binary build
FOREACH(source ${SOURCE})
  # Compute the name of the binary to create
  get_filename_component(binary ${source} NAME_WE)

  # From source compile the binary and add link rules
  add_executable(${binary} ${source})
  target_link_libraries(${binary} ${PROJECT_LIBRARY})

  # Add test
  add_test(${binary} ${binary})
ENDFOREACH(source)

