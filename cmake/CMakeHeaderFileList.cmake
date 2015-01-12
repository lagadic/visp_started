#############################################################################
#
# Description:
# Header files of the project
#
# Author:
# Fabien Spindler
#
##############################################################################

# Don't forget to update HEADER_ALL variable if you add/remove a 
# HEADER_subdir variable
#
# If you add/remove a directory, modify here

set(HEADER_FOO
  foo/myFoo.h
)

# Add here the other *.h files of your project
#set(HEADER_OTHER_FOLDER
#  other_folder/myFile.h
#)

set(HEADER_ALL 
  ${HEADER_FOO}
#  ${HEADER_OTHER_FOLDER}
)
