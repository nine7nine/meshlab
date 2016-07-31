include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/../../external/vcglib
  )

QT5_WRAP_CPP(moc_files edittexture.h)
QT5_WRAP_UI(uic_files textureeditor.ui)
set(edit_texture_SRCS
  edit_texture_factory.cpp 
  edittexture.cpp 
  textureeditor.cpp
  renderarea.cpp
  ../../external/vcglib/wrap/gui/trackball.cpp
  ../../external/vcglib/wrap/gui/trackmode.cpp
  ${moc_files}
  ${uic_files}
  ${rcc_files}
  )

add_library(edit_texture SHARED ${edit_texture_SRCS})
target_link_libraries(edit_texture ${QT_LIBRARIES} ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
install(TARGETS edit_texture
  RUNTIME DESTINATION ${BIN_DIR}
  LIBRARY DESTINATION ${LIB_DIR}
  ARCHIVE DESTINATION ${LIB_DIR})

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
