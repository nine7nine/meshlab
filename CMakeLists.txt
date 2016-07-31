# Copyright (c) 2016 Clifford Yapp
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# *****************************************************************************
# ***                       meshlab CMakeLists.txt                          ***
# *****************************************************************************

cmake_minimum_required(VERSION 3.0)
project(MESHLAB)

# Meshlab version information
set(MESHLAB_VERSION "1.3.3")

# Look here for custom CMake modules
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${MESHLAB_SOURCE_DIR}/CMake")

# Include path and rpath management modules
include("${MESHLAB_SOURCE_DIR}/CMake/RPath_Setup.cmake")
include("${MESHLAB_SOURCE_DIR}/CMake/Path_Setup.cmake")

# Shared and static lib build settings
if(NOT DEFINED BUILD_SHARED_LIBS)
  set(BUILD_SHARED_LIBS ON)
endif(NOT DEFINED BUILD_SHARED_LIBS)
if(NOT DEFINED BUILD_STATIC_LIBS)
  set(BUILD_STATIC_LIBS ON)
endif(NOT DEFINED BUILD_STATIC_LIBS)

# Figure out what to do with required libs that we also have
# as included sources
add_subdirectory(src/external)

# Check for the math library
include(CheckLibraryExists)
check_library_exists(m cos "" HAVE_M_LIBRARY)
if(HAVE_M_LIBRARY)
  set(M_LIBRARY m)
endif(HAVE_M_LIBRARY)

include(CheckIncludeFiles)
check_include_files(unistd.h HAVE_UNISTD_H)
if(HAVE_UNISTD_H)
  add_definitions(-DHAVE_UNISTD_H=1)
endif(HAVE_UNISTD_H)

include(CheckCCompilerFlag)
check_c_compiler_flag(-fPIC HAVE_FPIC)
if(HAVE_FPIC)
  add_definitions(-fPIC)
endif(HAVE_FPIC)

find_package(OpenGL REQUIRED)
find_package(Threads REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5OpenGL REQUIRED)
find_package(Qt5Xml REQUIRED)
find_package(Qt5XmlPatterns REQUIRED)
find_package(Qt5Script REQUIRED)

set(QT_LIBRARIES Qt5::Widgets Qt5::OpenGL Qt5::Xml Qt5::XmlPatterns Qt5::Script)

add_subdirectory(src)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

