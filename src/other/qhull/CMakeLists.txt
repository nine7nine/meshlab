# CMakeLists.txt -- CMake configuration file for qhull, qhull6, and related programs
#
# To install CMake
#   Download from http://www.cmake.org/download/
#
# To find the available targets for CMake -G "..."
#   cmake --help
#
# To build with MSYS/mingw
#   cd build && cmake -G "MSYS Makefiles" .. && cmake ..
#   make
#   make install
#
# To uninstall on unix or MSYS/mingw
#   xargs rm <build/install_manifest.txt
#
# To build Qhull with Visual Studio projects, run cmake twice
#   To install bin/doc/include/lib in the current directory
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 11 2012" .. && cmake -DCMAKE_INSTALL_PREFIX=.. ..
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 11 2012 Win64" .. && cmake -DCMAKE_INSTALL_PREFIX=.. ..
#   To install into Program Files/qhull
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 11 2012" .. && cmake ..
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 11 2012 Win64" .. && cmake ..
#   To build for Visual Studio 2005 and install into Program Files/qhull
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 8 2005" .. && cmake  ..
#      mkdir -p build-cmake && cd build-cmake && cmake -G "Visual Studio 8 2005 Win64" .. && cmake  ..
#   Double click build-cmake/qhull-all.sln
#   Build INSTALL to copy files into C:/Program Files/qhull
#
# Additional build targets
#   qhullp -- Same as qhull using qh_QHpointer and deprecated libqhull_p
#   user_egp -- Same as user_eg using qh_QHpointer and deprecated libqhull_p
#
# Notes on Visual Studio projects
#   You may need to copy bin/msvcr80.dll into C:/Program Files/qhull/bin
#   If using library debug targets, please rename with '_d' (e.g., qhullstatic_d.lib)
# 
# Troubleshooting
#   "No CMAKE_C_COMPILER could be found"
#     cmake was not able to find the build environment specified (e.g., Visual Studio 11)
# 
# To uninstall on Windows
#   Delete C:/Program Files/qhull
#
# If creating a qhull package, please include a pkg-config file based on build/qhull*.pc.in
#
# For qhulltest, use the Qt build (src/qhull-all.pro)
#
# Qhull ships with cmake-derived sln and proj files for DevStudio 8 2005
#   See eg/make-vcproj.sh
#   Change to relative paths
#   Remove ZERO_CHECK, ALL_BUILD, and INSTALL projects
#   Change targets to bin/ and lib/ directories
#   Disable incremental linking and ilk files (LinkIncremental="1")
#   Disable Run-Time Type Info (rtti)
#   Remove src/libqhullcpp from most of the AdditionalIncludeDirectories
#   Remove CMAKE_INTDIR from PreprocessorDefinitions
#   Adjust target names and destinations (e.g., lib/libqhullstatic_rd.a)
#  
# $Id: //main/2015/qhull/CMakeLists.txt#8 $$Change: 2066 $
# $DateTime: 2016/01/18 19:29:17 $$Author: bbarber $

project(qhull)
cmake_minimum_required(VERSION 2.6)

# Define qhull_VERSION in CMakeLists.txt, Makefile, qhull-exports.def, qhull_p-exports.def, qhull_r-exports.def, qhull-warn.pri
set(qhull_VERSION2 "2015.2 2016/01/18")  # not used, See global.c, global_r.c, rbox.c, rbox_r.c
set(qhull_VERSION     "7.2.0")  # Advance every release

# SOVERSION -- qhull 2003 = empty, 2009 = 5, 2010-2012 = 6, 2015 (reentrant) = 7
set(qhull_SOVERSION 7) # For SOVERSION 

include(CMakeModules/CheckLFS.cmake)
option(WITH_LFS "Enable Large File Support" ON)
check_lfs(WITH_LFS)

# ---------------------------------------
# Define library source files and variables
#
# Files for individual targets are defined with the target
# ---------------------------------------

# Order libqhull object files by frequency of execution.  Small files at end.

# Non-reentrant Qhull
set(
    libqhull_HEADERS
        src/libqhull/libqhull.h
        src/libqhull/geom.h
        src/libqhull/io.h
        src/libqhull/mem.h
        src/libqhull/merge.h
        src/libqhull/poly.h
        src/libqhull/qhull_a.h
        src/libqhull/qset.h
        src/libqhull/random.h
        src/libqhull/stat.h
        src/libqhull/user.h
)
set(
    libqhull_SOURCES
        src/libqhull/global.c
        src/libqhull/stat.c
        src/libqhull/geom2.c
        src/libqhull/poly2.c
        src/libqhull/merge.c
        src/libqhull/libqhull.c
        src/libqhull/geom.c
        src/libqhull/poly.c
        src/libqhull/qset.c
        src/libqhull/mem.c
        src/libqhull/random.c
        src/libqhull/usermem.c
        src/libqhull/userprintf.c
        src/libqhull/io.c
        src/libqhull/user.c
        src/libqhull/rboxlib.c
        src/libqhull/userprintf_rbox.c
        ${libqhull_HEADERS}
)

set(
    libqhull_DOC
        src/libqhull/index.htm
        src/libqhull/qh-geom.htm
        src/libqhull/qh-globa.htm
        src/libqhull/qh-io.htm
        src/libqhull/qh-mem.htm
        src/libqhull/qh-merge.htm
        src/libqhull/qh-poly.htm
        src/libqhull/qh-qhull.htm
        src/libqhull/qh-set.htm
        src/libqhull/qh-stat.htm
        src/libqhull/qh-user.htm    
        src/libqhull/DEPRECATED.txt    
)

set(
    testqset_HEADERS
        src/libqhull/mem.h
        src/libqhull/qset.h
)
set(
    testqset_SOURCES
        src/libqhull/qset.c
        src/libqhull/mem.c
        src/libqhull/usermem.c
        src/testqset/testqset.c
        ${testqset_HEADERS}
)

include_directories(${CMAKE_SOURCE_DIR}/src)


# ---------------------------------------
# Define static libraries qhullstatic (non-reentrant) and qhullstatic_r (reentrant)
# ---------------------------------------
add_definitions(-fPIC)
add_library(qhull_static STATIC ${libqhull_SOURCES})
set_target_properties(qhull_static PROPERTIES
    VERSION ${qhull_VERSION})
if(UNIX)
    target_link_libraries(qhull_static m)
endif(UNIX)

# ---------------------------------------
# Define install
# ---------------------------------------

install(TARGETS ${qhull_TARGETS_INSTALL}
        RUNTIME DESTINATION ${BIN_INSTALL_DIR}
        LIBRARY DESTINATION ${LIB_INSTALL_DIR}
        ARCHIVE DESTINATION ${LIB_INSTALL_DIR})

install(FILES ${libqhull_HEADERS}    DESTINATION ${INCLUDE_INSTALL_DIR}/libqhull)
install(FILES ${libqhull_DOC}        DESTINATION ${INCLUDE_INSTALL_DIR}/libqhull)
install(FILES ${libqhullr_HEADERS}    DESTINATION ${INCLUDE_INSTALL_DIR}/libqhull_r)
install(FILES ${libqhullr_DOC}        DESTINATION ${INCLUDE_INSTALL_DIR}/libqhull_r)
install(FILES ${libqhullcpp_HEADERS} DESTINATION ${INCLUDE_INSTALL_DIR}/libqhullcpp)
