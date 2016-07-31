# Temporary settings until third party build logic is
# up and working
set(VCG_INCLUDE_DIR ${MESHLAB_SOURCE_DIR}/src/external/vcglib)
set(GLEW_INCLUDE_DIR ${MESHLAB_SOURCE_DIR}/src/external/glew/include)

# Common include directories used by most MeshLab code
include_directories(
  ${VCG_INCLUDE_DIR}
  ${GLEW_INCLUDE_DIR}
  ${X11_X11_INCLUDE_PATH}
  ${MESHLAB_SOURCE_DIR}/src
  ${Qt5Widgets_INCLUDE_DIRS}
  ${Qt5OpenGL_INCLUDE_DIRS}
  ${Qt5Xml_INCLUDE_DIRS}
  ${Qt5XmlPatterns_INCLUDE_DIRS}
  ${Qt5Script_INCLUDE_DIRS}
  ${QT_MKSPECS_DIR}
  )

# Platform specific inc directory
include(CheckTypeSize)
# calculate the size of a pointer if we haven't already
CHECK_TYPE_SIZE("void *" CMAKE_SIZEOF_VOID_P)

# 64 bit
if(${CMAKE_SIZEOF_VOID_P} MATCHES "^8$")
  if(WIN32)
  endif(WIN32)
  if(APPLE)
  endif(APPLE)
  if("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/external/inc/linux-g++-64/mpir-2.4.0)
  endif("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
# 32 bit
else(${CMAKE_SIZEOF_VOID_P} MATCHES "^8$")
  if(WIN32)
  endif(WIN32)
  if(APPLE)
  endif(APPLE)
  if("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
  endif("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
endif(${CMAKE_SIZEOF_VOID_P} MATCHES "^8$")

add_subdirectory(common)
add_subdirectory(meshlab)
add_subdirectory(plugins)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
