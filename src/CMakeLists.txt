#############################################################################
#
# Description:
# CMakeList for the source directory
#
# Author:
# Fabien Spindler
#
##############################################################################
#----------------------------------------------------------------------
# Include project files 
#----------------------------------------------------------------------
# include all the Example project .cpp files
include(${PROJECT_SOURCE_DIR}/cmake/CMakeSourceFileList.cmake)
# include all the Example project .h files
INCLUDE(${PROJECT_SOURCE_DIR}/cmake/CMakeHeaderFileList.cmake)


#----------------------------------------------------------------------
# Create rule to copy all the headers from src to include/tpe
#----------------------------------------------------------------------
# For each header, we create a rule
SET(HEADER_IN_INCLUDE_DIR "")
SET(ADDED_SRC_DEPEND_PROPERTIES "")
FOREACH(header ${HEADER_ALL})
  GET_FILENAME_COMPONENT(headerName ${header} NAME) 
  ADD_CUSTOM_COMMAND(
    OUTPUT ${PROJECT_BINARY_DIR}/include/${PROJECT_INCLUDE_PREFIX}/${headerName}
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/${header} ${PROJECT_BINARY_DIR}/include/${PROJECT_INCLUDE_PREFIX}/${headerName}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${header}
    )
  SET(HEADER_IN_INCLUDE_DIR ${HEADER_IN_INCLUDE_DIR} ${PROJECT_BINARY_DIR}/include/${PROJECT_INCLUDE_PREFIX}/${headerName}
    )
ENDFOREACH(header)

#----------------------------------------------------------------------
# Create a top level rule to copy all the headers from src to include/tpe
#----------------------------------------------------------------------
ADD_CUSTOM_TARGET(header ALL
  DEPENDS ${HEADER_IN_INCLUDE_DIR}
  )

#----------------------------------------------------------------------
# build rule for the library
#----------------------------------------------------------------------
ADD_LIBRARY (${PROJECT_LIBRARY}
  ${SRC_ALL} 
  ${HEADER_ALL}
  ${PROJECT_INCLUDE_DIR}/${PROJECT_INCLUDE_PREFIX}/myConfig.h
  ) 

# create the headers in include/tpe before compiling the lib
ADD_DEPENDENCIES(${PROJECT_LIBRARY} header)

# Append the library version information to the library target
# properties. 
SET_TARGET_PROPERTIES(${PROJECT_LIBRARY}
  PROPERTIES
  VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
  SOVERSION ${PROJECT_VERSION_PATCH}
  )

#----------------------------------------------------------------------
# customize install target 
#----------------------------------------------------------------------
# install rule for the library
INSTALL(TARGETS ${PROJECT_LIBRARY}
  DESTINATION lib
  PERMISSIONS OWNER_READ GROUP_READ WORLD_READ OWNER_WRITE
  )
# install rule for all the headers
INSTALL(FILES ${HEADER_ALL}
  DESTINATION include/${PROJECT_LIBRARY_NAME}
  PERMISSIONS OWNER_READ GROUP_READ WORLD_READ OWNER_WRITE
  )
  
