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

NOTE: FOGLAMP_INCLUDES must be used with FogLAMP header files all available in a single path

Exmaples:

cmake -DUSE_FOGLAMP_ROOT=ON ..
cmake -DFOGLAMP_SRC_DIR=/home/source/develop/FogLAMP  ..
cmake -DFOGLAMP_LIBS=/home/dev/package/lib ..
cmake -DFOGLAMP_INCLUDES=/dev-package/include ..

Once plugin has been built it has to be copied into an existing FogLAMP setup.
