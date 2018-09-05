cmake_minimum_required(VERSION 2.4.0)

# Set the plugin name to build
project(Random)

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -ggdb")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# Add here all needed FogLAMP libraries as list
set(NEEDED_FOGLAMP_LIBS common-lib)
# Add here additional needed libraries
#set(ADD_LIBS -lmylib)

# Find source files
file(GLOB SOURCES *.cpp)

# Find FogLAMP includes and libs, by including FindFogLAMP.cmak file
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})
find_package(FogLAMP)
# If errors: make clean and remove Makefile
if (NOT FOGLAMP_SUCCESS)
	if (EXISTS "${CMAKE_BINARY_DIR}/Makefile")
		execute_process(COMMAND make clean WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
		file(REMOVE "${CMAKE_BINARY_DIR}/Makefile")
	endif()
	# Stop the build process
	message(FATAL_ERROR "FogLAMP plugin '${PROJECT_NAME}' build error.")
endif()

# Add ./include
include_directories(include)
# Add FogLAMP include dir(s)
include_directories(${FOGLAMP_INCLUDE_DIRS})

# Add other include paths
#include_directories("/usr/include/mylib")

# Add FogLAMP lib path
link_directories(${FOGLAMP_LIBS_DIR})

# Create shared library
add_library(${PROJECT_NAME} SHARED ${SOURCES})
# Add FogLAMP library names
target_link_libraries(${PROJECT_NAME} ${NEEDED_FOGLAMP_LIBS})
# Add additional libraries
#target_link_libraries(${PROJECT_NAME} ${ADD_LIBS})
# Set the build version 
set_target_properties(${PROJECT_NAME} PROPERTIES SOVERSION 1)

set(FOGLAMP_INSTALL_DIR "" CACHE INTERNAL "")
# Install library
if (FOGLAMP_INSTALL_DIR)
	message(STATUS "Installing ${PROJECT_NAME} in ${FOGLAMP_INSTALL_DIR}/plugins/south/${PROJECT_NAME}")
	install(TARGETS ${PROJECT_NAME} DESTINATION ${FOGLAMP_INSTALL_DIR}/plugins/south/${PROJECT_NAME})
endif()
