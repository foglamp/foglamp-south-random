FogLAMP "random" C++ South plugin

Build
----
To build FogLAMP Random C++ South plugin:
- mkdir build
- cd build
- cmake ..

There are some options to pass to cmake:
- FOGLAMP_SRC_DIR sets the path of a FogLAMP source tree
- USE_FOGLAMP_ROOT [ON | OFF]. If set existing FOGLAMP_ROOT env var is set as FOGLAMP_SRC_DIR
- FOGLAMP_INCLUDES sets the path to FogLAMP header files
- FOGLAMP_LIBS sets the path to FogLAMP libraries
- FOGLAMP_INSTALL_DIR sets the installtion path of Random plugin

NOTE:
 - FOGLAMP_INCLUDES must be used with FogLAMP header files all available in a single path
 - 'make install' target is defined only when FOGLAMP_INSTALL_DIR is set

Exmaples:

cmake -DUSE_FOGLAMP_ROOT=ON ..
cmake -DFOGLAMP_SRC_DIR=/home/source/develop/FogLAMP  ..
cmake -DFOGLAMP_LIBS=/home/dev/package/lib ..
cmake -DFOGLAMP_INCLUDES=/dev-package/include ..
cmake -DFOGLAMP_INSTALL_DIR=/home/source/develop/FogLAMP
cmake -DFOGLAMP_INSTALL_DIR=/usr/local/foglamp
