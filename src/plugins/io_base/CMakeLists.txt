include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

QT5_WRAP_CPP(moc_files baseio.h)

set(io_base_SRCS
  baseio.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  ${moc_files}
  )

add_library(io_base SHARED ${io_base_SRCS})
target_link_libraries(io_base ${QT_LIBRARIES} ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
install(TARGETS io_base
  RUNTIME DESTINATION ${BIN_DIR}
  LIBRARY DESTINATION ${LIB_DIR}
  ARCHIVE DESTINATION ${LIB_DIR})

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
