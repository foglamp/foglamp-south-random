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
unset(USE_FOGLAMP_ROOT CACHE)
set(FOGLAMP_SRC_DIR "" CACHE INTERNAL "")
set(FOGLAMP_DEFAULT_INCLUDE_DIR "/usr/include/foglamp" CACHE INTERNAL "")
set(FOGLAMP_DEFAULT_LIBS_DIR "/usr/lib/foglamp" CACHE INTERNAL "")

# -DUSE_FOGLAMP_ROOT=ON
if (USE_FOGLAMP_ROOT)
	# Use FOGLAMP_ROOT path
	set(FOGLAMP_SRC_DIR $ENV{FOGLAMP_ROOT})
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
else()
	# -DFOGLAMP_INCLUDES=/some_path
	if (NOT FOGLAMP_INCLUDES)
		set(FOGLAMP_INCLUDES ${FOGLAMP_DEFAULT_INCLUDE_DIR})
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
endif()

if (NOT FOGLAMP_INCLUDE_DIRS)
	message(SEND_ERROR "FogLAMP include dir not set")
	return()
endif()

list(REMOVE_DUPLICATES FOGLAMP_INCLUDE_DIRS)

string (REPLACE ";" "\n  +" DISPLAY_PATHS "${FOGLAMP_INCLUDE_DIRS}")
message(STATUS "Using FOGLAMP_INCLUDE_DIRS\n  +" "${DISPLAY_PATHS}")

#
# FogLAMP Libraries
#
# Check -DFOGLAMP_LIBS_DIR=/some path is valid
# or use FOGLAMP_SRC_DIR/cmake_build/C/lib
# FOGLAMP_SRC_DIR might have been set to FOGLAMP_ROOT above
#
if (FOGLAMP_SRC_DIR)
        set(FOGLAMP_LIBS_DIR "${FOGLAMP_SRC_DIR}/cmake_build/C/lib")
	if (NOT EXISTS "${FOGLAMP_SRC_DIR}/cmake_build")
		message(SEND_ERROR "FogLAMP has not been built yet in ${FOGLAMP_SRC_DIR}  Compile it first.")
		return()
	endif()
else()
	if (NOT FOGLAMP_LIBS_DIR)
		set(FOGLAMP_LIBS_DIR ${FOGLAMP_DEFAULT_LIBS_DIR})
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

message(STATUS "Using FOGLAMP_LIBS_DIR is " ${FOGLAMP_LIBS_DIR})

set(FOGLAMP_SUCCESS "true")
