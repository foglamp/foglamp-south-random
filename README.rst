FogLAMP "random" C++ South plugin

Build
----
To build FogLAMP Random C++ South plugin:
- mkdir build
- cd build
- cmake ..

- By default the FogLAMP develop package header files an libraries
  are in use: /usr/include/foglamp and /usr/lib/foglamp
- If FOGLAMP_ROOT env var is set and no -D options are set,
  the header files and libraries paths are set to FOGLAMP_ROOT dir

Options to pass to cmake:
- FOGLAMP_SRC_DIR sets the path of a FogLAMP source tree
- FOGLAMP_INCLUDES sets the path to FogLAMP header files
- FOGLAMP_LIBS sets the path to FogLAMP libraries
- FOGLAMP_INSTALL_DIR sets the installation path of Random plugin

NOTE:
 - FOGLAMP_INCLUDES must be used with FogLAMP header files all available in a single path
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
