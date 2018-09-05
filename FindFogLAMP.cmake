# This CMake file locates the FogLAMP header files and libraries
#
# The following variables are set:
# FOGLAMP_INCLUDE_DIRS - Path to FogLAMP headers files found
# FOGLAMP_LIBS_DIR - Path to FogLAMP shared libraries
# FOGLAMP_SUCCESS - Set on succes
#
# In case of error use SEND_ERROR and return()
#
# Remove vars from cache
set(USE_FOGLAMP_ROOT OFF CACHE INTERNAL OFF)
set(FOGLAMP_SRC_DIR "" CACHE INTERNAL "")
set(FOGLAMP_DEFAULT_INCLUDE_DIR "/usr/include/foglamp" CACHE INTERNAL "")
set(FOGLAMP_DEFAULT_LIBS_DIR "/usr/lib/foglamp" CACHE INTERNAL "")
set(FOGLAMP_INCLUDES "" CACHE INTERNAL "")
set(FOGLAMP_LIBS_DIR "" CACHE INTERNAL "")

# No options set
# If FOGLAMP_ROOT env var is set, use it
if (NOT FOGLAMP_SRC_DIR AND NOT FOGLAMP_INCLUDES AND NOT FOGLAMP_LIBS_DIR)
	if (DEFINED ENV{FOGLAMP_ROOT})
		message(STATUS "No options set.\n" 
			"   +Using found FOGLAMP_ROOT $ENV{FOGLAMP_ROOT}")
		set(FOGLAMP_SRC_DIR $ENV{FOGLAMP_ROOT})
	endif()
endif()

# -DFOGLAMP_SRC_DIR=/some_path or FOGLAMP_ROOT path
if (FOGLAMP_SRC_DIR)
	unset(_INCLUDE_LIST CACHE)
	file(GLOB_RECURSE _INCLUDE_COMMON "${FOGLAMP_SRC_DIR}/C/common/*.h")
	file(GLOB_RECURSE _INCLUDE_SERVICES "${FOGLAMP_SRC_DIR}/C/services/common/*.h")
	list(APPEND _INCLUDE_LIST ${_INCLUDE_COMMON} ${_INCLUDE_SERVICES})
	foreach(_ITEM ${_INCLUDE_LIST})
		get_filename_component(_ITEM_PATH ${_ITEM} DIRECTORY)
		list(APPEND FOGLAMP_INCLUDE_DIRS ${_ITEM_PATH})
	endforeach()
	unset(INCLUDE_LIST CACHE)

	list(REMOVE_DUPLICATES FOGLAMP_INCLUDE_DIRS)

	string (REPLACE ";" "\n   +" DISPLAY_PATHS "${FOGLAMP_INCLUDE_DIRS}")
	if (NOT DEFINED ENV{FOGLAMP_ROOT})
		message(STATUS "Using -DFOGLAMP_SRC_DIR option for includes\n   +" "${DISPLAY_PATHS}")
	else()
		message(STATUS "Using FOGLAMP_ROOT for includes\n   +" "${DISPLAY_PATHS}")
	endif()

	if (NOT FOGLAMP_INCLUDE_DIRS)
		message(SEND_ERROR "Needed FogLAMP header files not found in path ${FOGLAMP_SRC_DIR}/C")
		return()
	endif()
else()
	# -DFOGLAMP_INCLUDES=/some_path
	if (NOT FOGLAMP_INCLUDES)
		set(FOGLAMP_INCLUDES ${FOGLAMP_DEFAULT_INCLUDE_DIR})
		message(STATUS "Using FogLAMP dev package includes " ${FOGLAMP_INCLUDES})
	else()
		message(STATUS "Using -DFOGLAMP_INCLUDES option " ${FOGLAMP_INCLUDES})
	endif()
	# Remove current value from cache
	unset(_FIND_INCLUDES CACHE)
	# Get up to date var from find_path
	find_path(_FIND_INCLUDES NAMES plugin_api.h PATHS ${FOGLAMP_INCLUDES})
	if (_FIND_INCLUDES)
		list(APPEND FOGLAMP_INCLUDE_DIRS ${_FIND_INCLUDES})
	endif()
	# Remove current value from cache
	unset(_FIND_INCLUDES CACHE)

	if (NOT FOGLAMP_INCLUDE_DIRS)
		message(SEND_ERROR "Needed FogLAMP headers file not found in path ${FOGLAMP_INCLUDE_DIRS}")
		return()
	endif()
endif()

#
# FogLAMP Libraries
#
# Check -DFOGLAMP_LIBS_DIR=/some path is valid
# or use FOGLAMP_SRC_DIR/cmake_build/C/lib
# FOGLAMP_SRC_DIR might have been set to FOGLAMP_ROOT above
#
if (FOGLAMP_SRC_DIR)
        set(FOGLAMP_LIBS_DIR "${FOGLAMP_SRC_DIR}/cmake_build/C/lib")
	if (NOT DEFINED ENV{FOGLAMP_ROOT})
		message(STATUS "Using -DFOGLAMP_SRC_DIR option for libs \n   +" ${FOGLAMP_LIBS_DIR})
	else()
		message(STATUS "Using FOGLAMP_ROOT for libs \n   +" ${FOGLAMP_LIBS_DIR})
	endif()

	if (NOT EXISTS "${FOGLAMP_SRC_DIR}/cmake_build")
		message(SEND_ERROR "FogLAMP has not been built yet in ${FOGLAMP_SRC_DIR}  Compile it first.")
		return()
	endif()
else()
	if (NOT FOGLAMP_LIBS_DIR)
		set(FOGLAMP_LIBS_DIR ${FOGLAMP_DEFAULT_LIBS_DIR})
		message(STATUS "Using FogLAMP dev package libs " ${FOGLAMP_LIBS_DIR})
	else()
		message(STATUS "Using -DFOGLAMP_LIBS_DIR option " ${FOGLAMP_LIBS_DIR})
	endif()
endif()

# Find libraries
foreach(_LIB ${NEEDED_FOGLAMP_LIBS})
	# Remove current value from cache
	unset(_FOUND_LIB CACHE)
	# Get up to date var from find_library
	find_library(_FOUND_LIB NAME ${_LIB} PATHS ${FOGLAMP_LIBS_DIR})
	if (_FOUND_LIB)
		# Extract path form founf library file
		get_filename_component(_DIR_LIB ${_FOUND_LIB} DIRECTORY)
	else()
		message(SEND_ERROR "Needed FogLAMP library ${_LIB} not found in ${FOGLAMP_LIBS_DIR}")
		return()
	endif()
	# Remove current value from cache
	unset(_FOUND_LIB CACHE)
endforeach()

set(FOGLAMP_SUCCESS "true")
