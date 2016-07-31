# CMakeLists.txt -- CMake configuration file for qhull, qhull6, and related programs

project(qhull)
cmake_minimum_required(VERSION 2.6)

set(qhull_VERSION "2003.1")

set(
    libqhull_HEADERS
        src/qhull.h
        src/geom.h
        src/io.h
        src/mem.h
        src/merge.h
        src/poly.h
        src/qhull_a.h
        src/qset.h
        src/stat.h
        src/user.h
)
set(
    libqhull_SOURCES
        src/global.c
        src/stat.c
        src/geom2.c
        src/poly2.c
        src/merge.c
        src/qhull.c
        src/geom.c
        src/poly.c
        src/qset.c
        src/mem.c
        src/io.c
        src/user.c
        ${libqhull_HEADERS}
)

include_directories(${CMAKE_SOURCE_DIR}/src)

# ---------------------------------------
# Define static libraries qhullstatic (non-reentrant) and qhullstatic_r (reentrant)
# ---------------------------------------
add_definitions(-fPIC)
add_library(qhull ${libqhull_SOURCES})
set_target_properties(qhull PROPERTIES
    VERSION ${qhull_VERSION})
if(UNIX)
    target_link_libraries(qhull m)
endif(UNIX)

# ---------------------------------------
# Define install
# ---------------------------------------

if(NOT DEFINED BIN_DIR)
	set(BIN_DIR bin)
endif(NOT DEFINED BIN_DIR)
if(NOT DEFINED LIB_DIR)
	set(LIB_DIR lib)
endif(NOT DEFINED LIB_DIR)

install(TARGETS qhull
        RUNTIME DESTINATION ${BIN_DIR}
        LIBRARY DESTINATION ${LIB_DIR}
        ARCHIVE DESTINATION ${LIB_DIR})

