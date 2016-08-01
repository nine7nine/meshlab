# Common include directories used by most MeshLab code
include_directories(
  ${MESHLAB_SOURCE_DIR}/src/external/vcglib
  ${MESHLAB_SOURCE_DIR}/src/external/glew/include
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

add_subdirectory(common)
add_subdirectory(meshlab)
add_subdirectory(plugins)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
