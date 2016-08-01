# Plugins constitute the majority of MeshLab's functionality. This
# function encompasses the most common build logic pattern

function(meshlab_plugin plugin base_srcs moc_hdrs)
  cmake_parse_arguments(MP "IGNORE" "" "INCLUDE_DIRS;DEPS;UIC;RCC" ${ARGN})
  if(NOT MP_IGNORE)
    set(added_plugins ${added_plugins} ${plugin} PARENT_SCOPE)
    QT5_WRAP_CPP(moc_files ${${moc_hdrs}})
    if(MP_UIC)
      QT5_WRAP_UI(uic_files ${${MP_UIC}})
    endif(MP_UIC)
    if(MP_RCC)
      QT5_ADD_RESOURCES(rcc_files ${${MP_RCC}})
    endif(MP_RCC)
    set(mp_base_srcs
      ${${base_srcs}}
      ${moc_files}
      ${uic_files}
      ${rcc_files}
      )
    add_library(${plugin} SHARED ${mp_base_srcs})
    target_link_libraries(${plugin} ${${MP_DEPS}} ${QT_LIBRARIES} ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
    if(MP_DEPS)
      foreach(dp ${${MP_DEPS}})
	if(TARGET ${dp})
	  add_dependencies(${plugin} ${dp})
	endif(TARGET ${dp})
      endforeach(dp ${${MP_DEPS}})
    endif(MP_DEPS)
    target_include_directories(${plugin} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/${plugin})
    if(MP_INCLUDE_DIRS)
      target_include_directories(${plugin} PUBLIC ${${MP_INCLUDE_DIRS}})
    endif(MP_INCLUDE_DIRS)
    install(TARGETS ${plugin}
      RUNTIME DESTINATION ${BIN_DIR}
      LIBRARY DESTINATION ${LIB_DIR}
      ARCHIVE DESTINATION ${LIB_DIR})
  else(NOT MP_IGNORE)
    set(disabled_plugins ${disabled_plugins} ${plugin} PARENT_SCOPE)
  endif(NOT MP_IGNORE)
endfunction()

# Plugins need to go into the 'plugins' directory in the same
# directory as the meshlab executable, so for this set of targets
# we need to override the toplevel defaults:

set(BIN_DIR_TMP ${BIN_DIR})
set(LIB_DIR_TMP ${LIB_DIR})
set(BIN_DIR ${BIN_DIR}/plugins)
set(LIB_DIR ${BIN_DIR})
if(NOT CMAKE_CONFIGURATION_TYPES)
  set(LIBOUT_TMP ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${MESHLAB_BINARY_DIR}/${LIB_DIR} CACHE INTERNAL "Single output directory for building all libraries.")
  set(ARCHIVEOUT_TMP ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${MESHLAB_BINARY_DIR}/${LIB_DIR} CACHE INTERNAL "Single output directory for building all archives.")
  set(RUNTIMEOUT_TMP ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${MESHLAB_BINARY_DIR}/${BIN_DIR} CACHE INTERNAL "Single output directory for building all executables.")
else(NOT CMAKE_CONFIGURATION_TYPES)
  set(CFG_ROOT ${MESHLAB_BINARY_DIR})
  foreach(CFG_TYPE ${CMAKE_CONFIGURATION_TYPES})
    if(NOT "${CMAKE_CFG_INTDIR}" STREQUAL ".")
      set(CFG_ROOT ${MESHLAB_BINARY_DIR}/${CFG_TYPE})
    endif(NOT "${CMAKE_CFG_INTDIR}" STREQUAL ".")
    string(TOUPPER "${CFG_TYPE}" CFG_TYPE_UPPER)
    set(LIBOUT_TMP_${CFG_TYPE_UPPER} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}})
    set("CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${CFG_ROOT}/${LIB_DIR} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} libraries.")
    set(ARCHIVEOUT_TMP_${CFG_TYPE_UPPER} ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}})
    set("CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${CFG_ROOT}/${LIB_DIR} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} archives.")
    set(RUNTIMEOUT_TMP_${CFG_TYPE_UPPER} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}})
    set("CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${CFG_ROOT}/${BIN_DIR} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} executables.")
  endforeach()
endif(NOT CMAKE_CONFIGURATION_TYPES)

# Qt Plugin definition
add_definitions(-DQT_PLUGIN)

# Always build the standard plugins
add_subdirectory(standard)

if(MESHLAB_PLUGINS_EXPERIMENTAL)
  add_subdirectory(experimental)
endif(MESHLAB_PLUGINS_EXPERIMENTAL)

if(MESHLAB_PLUGINS_UNSUPPORTED)
  add_subdirectory(unsupported)
endif(MESHLAB_PLUGINS_UNSUPPORTED)

if(MESHLAB_PLUGINS_SAMPLE)
  add_subdirectory(sample)
endif(MESHLAB_PLUGINS_SAMPLE)

if(MESHLAB_PLUGINS_FGT)
  add_subdirectory(fgt)
endif(MESHLAB_PLUGINS_FGT)


# Restore previous ouput directory settings

set(BIN_DIR ${BIN_DIR_TMP})
set(LIB_DIR ${LIB_DIR_TMP})
if(NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${LIBOUT_TMP}  CACHE INTERNAL "Single output directory for building all libraries.")
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARCHIVEOUT_TMP}  CACHE INTERNAL "Single output directory for building all archives.")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${RUNTIMEOUT_TMP}  CACHE INTERNAL "Single output directory for building all executables.")
else(NOT CMAKE_CONFIGURATION_TYPES)
  foreach(CFG_TYPE ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER "${CFG_TYPE}" CFG_TYPE_UPPER)
    set("CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${LIBOUT_TMP_${CFG_TYPE_UPPER}} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} libraries.")
    set("CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${ARCHIVEOUT_TMP_${CFG_TYPE_UPPER}} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} archives.")
    set("CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CFG_TYPE_UPPER}" ${RUNTIMEOUT_TMP_${CFG_TYPE_UPPER}} CACHE INTERNAL "Single output directory for building ${CFG_TYPE} executables.")
  endforeach()
endif(NOT CMAKE_CONFIGURATION_TYPES)


# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
