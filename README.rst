FogLAMP "random" C++ South plugin

Build
----
To build FogLAMP Random C++ South plugin:
- mkdir build
- cd build
- cmake ..

- By default the FogLAMP develop package header files and libraries
  are expected to be located in /usr/include/foglamp and /usr/lib/foglamp
- If FOGLAMP_ROOT env var is set and no -D options are set,
  the header files and libraries paths are pulled from the ones under the
  FOGLAMP_ROOT directory.
  Please note that you must first run 'make' in the FOGLAMP_ROOT directory.

You may also pass one or more of the following options to cmake to override 
this default behaviour:
- FOGLAMP_SRC_DIR sets the path of a FogLAMP source tree
- FOGLAMP_INCLUDES sets the path to FogLAMP header files
- FOGLAMP_LIBS sets the path to FogLAMP libraries
- FOGLAMP_INSTALL_DIR sets the installation path of Random plugin

NOTE:
 - The FOGLAMP_INCLUDES option should point to a location where all the FogLAMP 
   header files have been installed in a single directory.
 - The FOGLAMP_LIBS option should point to a location where all the FogLAMP
   libraries have been installed in a single directory.
 - 'make install' target is defined only when FOGLAMP_INSTALL_DIR is set

Examples:

- no options
  cmake ..
- no options and FOGLAMP_ROOT set
  export FOGLAMP_ROOT=/some_foglamp_setup
  cmake ..
- set FOGLAMP_SRC_DIR
  cmake -DFOGLAMP_SRC_DIR=/home/source/develop/FogLAMP  ..
- set FOGLAMP_INCLUDES
  cmake -DFOGLAMP_INCLUDES=/dev-package/include ..
- set FOGLAMP_LIBS
  cmake -DFOGLAMP_LIBS=/home/dev/package/lib ..
- set FOGLAMP_INSTALL_DIR
  cmake -DFOGLAMP_INSTALL_DIR=/home/source/develop/FogLAMP
  cmake -DFOGLAMP_INSTALL_DIR=/usr/local/foglamp
