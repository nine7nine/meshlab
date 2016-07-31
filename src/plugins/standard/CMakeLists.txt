function(meshlab_plugin plugin base_srcs moc_hdrs)
  cmake_parse_arguments(MP "" "" "INCLUDE_DIRS" ${ARGN})
  set(added_plugins ${added_plugins} ${plugin} PARENT_SCOPE)
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/${plugin})
  if(MP_INCLUDE_DIRS)
    include_directories(${MP_INCLUDE_DIRS})
  endif(MP_INCLUDE_DIRS)
  message("base_srcs ${base_srcs} ${${base_srcs}}")
  message("moc_hdrs ${moc_hdrs} ${${moc_hdrs}}")
  QT5_WRAP_CPP(moc_files ${${moc_hdrs}})
  set(mp_base_srcs
    ${${base_srcs}}
    ${moc_files}
    )
  add_library(${plugin} SHARED ${mp_base_srcs})
  target_link_libraries(${plugin} ${QT_LIBRARIES} ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
  install(TARGETS ${plugin}
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR})
endfunction()

# In order to spot plugins we aren't handling with the build logic, get a list
# of what's there and initialize an empty list that will be updated by the meshlab_plugin
# function
set(added_plugins)
file(GLOB dir_plugins RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")
file(GLOB dir_files LIST_DIRECTORIES false RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")
list(REMOVE_ITEM dir_plugins ${dir_files})

# ********************************
# ***** Input/Output plugins *****
# ********************************

set(io_base_srcs
  io_base/baseio.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(io_base_moc_hdrs
  io_base/baseio.h
  )
meshlab_plugin(io_base io_base_srcs io_base_moc_hdrs)

# ************************
# ***** Edit plugins *****
# ************************

# **************************
# ***** Filter plugins *****
# **************************

message("added_plugins: ${added_plugins}")

list(REMOVE_ITEM dir_plugins ${added_plugins})
if(dir_plugins)
  set(strlist)
  foreach(pl ${dir_plugins})
    set(strlist "${strlist}\n${pl}")
  endforeach(pl ${dir_plugins})
  message(WARNING "The following plugins were not added: ${strlist}")
endif(dir_plugins)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
