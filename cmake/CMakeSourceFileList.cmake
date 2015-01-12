#############################################################################
#
# Description:
# Source files of the project
#
# Author:
# Fabien Spindler
#
##############################################################################

# Don't forget to update SRC_ALL variable if you add/remove a SRC_subdir 
# variable
#
# If you add/remove a directory, modify here

set(SRC_FOO
  foo/myFoo.cpp
)

# Add here the other *.cpp files of your project
#set(SRC_OTHER_FOLDER
#  other_folder/myFile.cpp
#)

set(SRC_ALL
  ${SRC_FOO}
#  ${SRC_OTHER_FOLDER}
)
