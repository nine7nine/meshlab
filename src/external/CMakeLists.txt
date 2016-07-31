include(CheckCCompilerFlag)
check_c_compiler_flag(-fPIC HAVE_FPIC)
if(HAVE_FPIC)
  add_definitions(-fPIC)
endif(HAVE_FPIC)

add_subdirectory(glew)
add_subdirectory(qhull)
add_subdirectory(jhead)
add_subdirectory(lib3ds)
add_subdirectory(OpenCTM)
add_subdirectory(muparser)
add_subdirectory(levmar)
add_subdirectory(structuresynth)
add_subdirectory(bzip2)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

