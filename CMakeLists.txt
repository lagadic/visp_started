#############################################################################
#
# Description:
# Main CMakeList.txt of the project
#
# Author:
# Fabien Spindler
#
##############################################################################
project(visp_started)

# The project classes prefix.
set(PROJECT_INCLUDE_PREFIX "my")

#-----------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.0)

#-----------------------------------------------------------------------------
# Project version number. An even minor number corresponds to releases.
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}")
set(PROJECT_VERSION_FULL "${PROJECT_VERSION}.${PROJECT_VERSION_PATCH}")      

# where are user-specific cmake modules
set(PROJECT_CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${PROJECT_CMAKE_MODULE_PATH})

# The internal library name we want to create
string(TOLOWER ${PROJECT_NAME} PROJECT_LIBRARY_NAME)

#-----------------------------------------------------------------------------
# Add extra compilation flags under UNIX
#-----------------------------------------------------------------------------
include(${PROJECT_CMAKE_MODULE_PATH}/AddExtraCompilationFlags.cmake)
ADD_EXTRA_COMPILATION_FLAGS()

#--------------------------------------------------------------------
# Option management
#--------------------------------------------------------------------

# Choose static or shared libraries.
option(BUILD_SHARED_LIBS "Build shared libraries (.dll/.so) instead of static ones (.lib/.a)." ON)
# Build examples as an option.
option(BUILD_EXAMPLES "Build examples." ON)

#--------------------------------------------------------------------
# By default set release configuration
#--------------------------------------------------------------------
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build, options are: None Debug Release" FORCE)
endif()

#-----------------------------------------------------------------------------
# The library to build.
set(PROJECT_LIBRARY ${PROJECT_LIBRARY_NAME})

# The location of project headers.
set(PROJECT_INCLUDE_DIR ${PROJECT_BINARY_DIR}/include)

# The location of the project documentation
set(PROJECT_DOC_DIR "${PROJECT_BINARY_DIR}/doc")

# The location in which to install Example libraries.
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

# The location in which to install MP binaries.
set(BINARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

#----------------------------------------------------------------------
# Third party libraries
#----------------------------------------------------------------------
# ViSP
find_package(VISP REQUIRED)
if(VISP_FOUND)
#  include(${VISP_USE_FILE})
endif()

#----------------------------------------------------------------------
# Add intern include dir
#----------------------------------------------------------------------
include_directories(${PROJECT_INCLUDE_DIR})

#----------------------------------------------------------------------
# Add library path
#----------------------------------------------------------------------
link_directories(${LIBRARY_OUTPUT_PATH})

#----------------------------------------------------------------------
# add "doc" target for doxygen documentation building
#----------------------------------------------------------------------
find_package(Doxygen)
if (DOXYGEN_FOUND)
  if(DOXYGEN_DOT_EXECUTABLE)
    set(PROJECT_HAVE_DOT "yes")      
  else()
    set(PROJECT_HAVE_DOT "no")  
  endif()
  ## we need latex for doxygen because of the formulas
  find_package(LATEX)
  if    (NOT LATEX_COMPILER)
    message(STATUS "latex command LATEX_COMPILER not found but usually required. You will probably get warnings and user interaction on doxy run.")
  endif ()
  if    (NOT MAKEINDEX_COMPILER)
    message(STATUS "makeindex command MAKEINDEX_COMPILER not found but usually required.")
  endif ()
  if    (NOT DVIPS_CONVERTER)
    message(STATUS "dvips command DVIPS_CONVERTER not found but usually required.")
  endif ()
   
  configure_file(${PROJECT_SOURCE_DIR}/doc/config-doxygen.cmake
    ${PROJECT_DOC_DIR}/config-doxygen
    @ONLY )

  add_custom_target(doc ${DOXYGEN_EXECUTABLE} ${PROJECT_DOC_DIR}/config-doxygen)
endif()

#----------------------------------------------------------------------
# Generate the package dependent file include/${PROJECT_LIBRARY_NAME}/myConfig.h
#----------------------------------------------------------------------
configure_file(${PROJECT_SOURCE_DIR}/include/myConfig.h.cmake 
  "${PROJECT_INCLUDE_DIR}/${PROJECT_INCLUDE_PREFIX}/myConfig.h"
)

#----------------------------------------------------------------------
# Propagation in sub dirs
#----------------------------------------------------------------------
subdirs(src)

if(BUILD_EXAMPLES)
  subdirs(example/foo)
endif()


