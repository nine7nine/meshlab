include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/../../external/qhull-2003.1/src
  )

QT5_WRAP_CPP(moc_files filter_qhull.h)

set(filter_qhull_SRCS
  filter_qhull.cpp
  qhull_tools.cpp
  ${moc_files}
  )

add_library(filter_qhull SHARED ${filter_qhull_SRCS})
target_link_libraries(filter_qhull qhull_static ${QT_LIBRARIES} ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
install(TARGETS filter_qhull
  RUNTIME DESTINATION ${BIN_DIR}
  LIBRARY DESTINATION ${LIB_DIR}
  ARCHIVE DESTINATION ${LIB_DIR})

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
