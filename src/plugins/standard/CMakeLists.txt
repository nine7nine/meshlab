# In order to spot plugins we aren't handling with the build logic, get a list
# of what's there and initialize an empty list that will be updated by the meshlab_plugin
# function
set(added_plugins)
file(GLOB dir_plugins RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")
file(GLOB dir_files LIST_DIRECTORIES false RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")
list(REMOVE_ITEM dir_plugins ${dir_files})

include_directories(${CMAKE_CURRENT_BINARY_DIR})

# ********************************
# ***** Input/Output plugins *****
# ********************************

# Basic IO
set(io_base_srcs
  io_base/baseio.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(io_base_moc_hdrs io_base/baseio.h)
meshlab_plugin(io_base io_base_srcs io_base_moc_hdrs)

# 3DS (3D-Studio Release 3 and 4) file support
set(io_3ds_srcs io_3ds/meshio.cpp)
set(io_3ds_moc_hdrs io_3ds/meshio.h)
set(io_3ds_incdirs ../../external/lib3ds)
set(io_3ds_deps 3ds)
meshlab_plugin(io_3ds io_3ds_srcs io_3ds_moc_hdrs
  INCLUDE_DIRS io_3ds_incdirs
  DEPS io_3ds_deps
  )

# Breuckmann file format (bre)
set(io_bre_srcs io_bre/io_bre.cpp)
set(io_bre_moc_hdrs io_bre/io_bre.h)
meshlab_plugin(io_bre io_bre_srcs io_bre_moc_hdrs)

# Collada
set(io_collada_srcs
  io_collada/io_collada.cpp
  ../../external/vcglib/wrap/dae/xmldocumentmanaging.cpp
  )
set(io_collada_moc_hdrs io_collada/io_collada.h)
meshlab_plugin(io_collada io_collada_srcs io_collada_moc_hdrs)

# Open Compressed Triangle Mesh format
set(io_ctm_srcs io_ctm/io_ctm.cpp)
set(io_ctm_moc_hdrs io_ctm/io_ctm.h)
set(io_ctm_incdirs ../../external/OpenCTM/lib)
set(io_ctm_deps openctm)
meshlab_plugin(io_ctm io_ctm_srcs io_ctm_moc_hdrs
  INCLUDE_DIRS io_ctm_incdirs
  DEPS io_ctm_deps
  )

# JSON
set(io_json_srcs io_json/io_json.cpp)
set(io_json_moc_hdrs io_json/io_json.h)
meshlab_plugin(io_json io_json_srcs io_json_moc_hdrs)

# U3D
set(io_u3d_srcs
  io_u3d/io_u3d.cpp
  ../../common/pluginmanager.cpp
  )
set(io_u3d_moc_hdrs io_u3d/io_u3d.h)
meshlab_plugin(io_u3d io_u3d_srcs io_u3d_moc_hdrs)

# tri
set(io_tri_srcs io_tri/io_tri.cpp)
set(io_tri_moc_hdrs io_tri/io_tri.h)
meshlab_plugin(io_tri io_tri_srcs io_tri_moc_hdrs)

# X3D
set(io_x3d_srcs
  io_x3d/io_x3d.cpp
  io_x3d/vrml/Parser.cpp
  io_x3d/vrml/Scanner.cpp
  )
set(io_x3d_moc_hdrs io_x3d/io_x3d.h)
meshlab_plugin(io_x3d io_x3d_srcs io_x3d_moc_hdrs)

# gts
set(io_gts_srcs io_gts/io_gts.cpp)
set(io_gts_moc_hdrs io_gts/io_gts.h)
meshlab_plugin(io_gts io_gts_srcs io_gts_moc_hdrs)

# expe
set(io_expe_srcs io_expe/io_expe.cpp)
set(io_expe_moc_hdrs io_expe/io_expe.h)
meshlab_plugin(io_expe io_expe_srcs io_expe_moc_hdrs)

# pdb
set(io_pdb_srcs
  io_pdb/io_pdb.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(io_pdb_moc_hdrs io_pdb/io_pdb.h)
meshlab_plugin(io_pdb io_pdb_srcs io_pdb_moc_hdrs)

# ************************
# ***** Edit plugins *****
# ************************

# Edit align
set(edit_align_srcs
  edit_align/edit_align_factory.cpp
  edit_align/point_matching_scale.cpp
  edit_align/edit_align.cpp
  edit_align/meshtree.cpp
  edit_align/alignDialog.cpp
  edit_align/AlignPairWidget.cpp
  edit_align/AlignPairDialog.cpp
  edit_align/align/AlignPair.cpp
  edit_align/align/AlignGlobal.cpp
  edit_align/align/OccupancyGrid.cpp
  edit_align/align/align_parameter.cpp
  ../../meshlab/stdpardialog.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  ../../external/vcglib/wrap/gui/trackball.cpp
  ../../external/vcglib/wrap/gui/trackmode.cpp
  )
set(edit_align_moc_hdrs
  edit_align/edit_align_factory.h
  edit_align/edit_align.h
  edit_align/alignDialog.h
  edit_align/AlignPairDialog.h
  edit_align/AlignPairWidget.h
  )
set(edit_align_uic edit_align/alignDialog.ui)
set(edit_align_rcc edit_align/edit_align.qrc)
set(edit_align_incdirs ../../external)
meshlab_plugin(edit_align edit_align_srcs edit_align_moc_hdrs
  INCLUDE_DIRS edit_align_incdirs
  UIC edit_align_uic
  RCC edit_align_rcc
  )

# Edit arc3D
set(edit_arc3D_srcs
  edit_arc3D/edit_arc3D.cpp
  edit_arc3D/edit_arc3D_factory.cpp
  edit_arc3D/arc3D_camera.cpp
  edit_arc3D/radial_distortion.cpp
  edit_arc3D/scalar_image.cpp
  edit_arc3D/v3dImportDialog.cpp
  edit_arc3D/maskRenderWidget.cpp
  edit_arc3D/maskImageWidget.cpp
  edit_arc3D/fillImage.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(edit_arc3D_moc_hdrs edit_arc3D/edit_arc3D.h)
set(edit_arc3D_uic edit_arc3D/ui/v3dImportDialog.ui)
set(edit_arc3D_rcc edit_arc3D/edit_arc3D.qrc)
set(edit_arc3D_incdirs ../../external)
set(edit_arc3D_deps bzip2)
meshlab_plugin(edit_arc3D edit_arc3D_srcs edit_arc3D_moc_hdrs
  INCLUDE_DIRS edit_arc3D_incdirs
  UIC edit_arc3D_uic
  RCC edit_arc3D_rcc
  DEPS edit_arc3D_deps
  )

# Edit hole
set(edit_hole_srcs
  edit_hole/edit_hole.cpp
  edit_hole/edit_hole_factory.cpp
  edit_hole/fillerDialog.cpp
  edit_hole/holeListModel.cpp
  )
set(edit_hole_moc_hdrs edit_hole/edit_hole.h)
set(edit_hole_uic edit_hole/edit_hole.ui)
set(edit_hole_rcc edit_hole/edit_hole.qrc)
meshlab_plugin(edit_hole edit_hole_srcs edit_hole_moc_hdrs
  UIC edit_hole_uic
  RCC edit_hole_rcc
  )

# Edit manipulators
set(edit_manipulators_srcs
  edit_manipulators/edit_manipulators.cpp
  edit_manipulators/edit_manipulators_factory.cpp
  ../../external/vcglib/wrap/gui/trackball.cpp
  ../../external/vcglib/wrap/gui/trackmode.cpp
  )
set(edit_manipulators_moc_hdrs edit_manipulators/edit_manipulators.h)
set(edit_manipulators_rcc edit_manipulators/edit_manipulators.qrc)
set(edit_manipulators_incdirs ../../external)
meshlab_plugin(edit_manipulators edit_manipulators_srcs edit_manipulators_moc_hdrs
  INCLUDE_DIRS edit_manipulators_incdirs
  RCC edit_manipulators_rcc
  )

# Edit measure
set(edit_measure_srcs
  edit_measure/edit_measure.cpp
  edit_measure/edit_measure_factory.cpp
  ../../external/vcglib/wrap/gui/rubberband.cpp
  )
set(edit_measure_moc_hdrs edit_measure/edit_measure.h)
set(edit_measure_rcc edit_measure/edit_measure.qrc)
set(edit_measure_incdirs ../../external)
meshlab_plugin(edit_measure edit_measure_srcs edit_measure_moc_hdrs
  INCLUDE_DIRS edit_measure_incdirs
  RCC edit_measure_rcc
  )

# Edit paint
set(edit_paint_srcs
  edit_paint/edit_paint.cpp
  edit_paint/edit_paint_factory.cpp
  edit_paint/paintbox.cpp
  )
set(edit_paint_moc_hdrs edit_paint/edit_paint.h)
set(edit_paint_uic edit_paint/paintbox.ui)
set(edit_paint_rcc edit_paint/edit_paint.qrc)
meshlab_plugin(edit_paint edit_paint_srcs edit_paint_moc_hdrs
  UIC edit_paint_uic
  RCC edit_paint_rcc
  )

# Edit pickpoints
set(edit_pickpoints_srcs
  edit_pickpoints/edit_pickpoints_factory.cpp
  edit_pickpoints/editpickpoints.cpp
  edit_pickpoints/pickpointsDialog.cpp
  edit_pickpoints/pickedPoints.cpp
  edit_pickpoints/pickPointsTemplate.cpp
  ../../meshlab/stdpardialog.cpp
  )
set(edit_pickpoints_moc_hdrs edit_pickpoints/editpickpoints.h)
set(edit_pickpoints_uic edit_pickpoints/pickpointsDialog.ui)
set(edit_pickpoints_rcc edit_pickpoints/editpickpoints.qrc)
set(edit_pickpoints_incdirs ../../meshlab)
meshlab_plugin(edit_pickpoints edit_pickpoints_srcs edit_pickpoints_moc_hdrs
  INCLUDE_DIRS edit_pickpoints_incdirs
  UIC edit_pickpoints_uic
  RCC edit_pickpoints_rcc
  )

# Edit point
set(edit_point_srcs
  edit_point/edit_point.cpp
  edit_point/edit_point_factory.cpp
  )
set(edit_point_moc_hdrs edit_point/edit_point.h)
set(edit_point_rcc edit_point/edit_point.qrc)
meshlab_plugin(edit_point edit_point_srcs edit_point_moc_hdrs
  RCC edit_point_rcc
  )

# Edit quality
set(edit_quality_srcs
  edit_quality/edit_quality_factory.cpp
  edit_quality/qualitymapper.cpp
  edit_quality/qualitymapperdialog.cpp
  edit_quality/common/transferfunction.cpp
  edit_quality/common/util.cpp
  edit_quality/common/meshmethods.cpp
  edit_quality/handle.cpp
  edit_quality/eqhandle.cpp
  edit_quality/tfhandle.cpp
  )
set(edit_quality_moc_hdrs edit_quality/qualitymapper.h)
set(edit_quality_uic edit_quality/qualitymapperdialog.ui)
set(edit_quality_rcc edit_quality/qualitymapper.qrc)
set(edit_quality_incdirs ../../common)
meshlab_plugin(edit_quality edit_quality_srcs edit_quality_moc_hdrs
  INCLUDE_DIRS edit_quality_incdirs
  UIC edit_quality_uic
  RCC edit_quality_rcc
  )

# Edit select
set(edit_select_srcs
  edit_select/edit_select.cpp
  edit_select/edit_select_factory.cpp
  )
set(edit_select_moc_hdrs edit_select/edit_select.h)
set(edit_select_rcc edit_select/edit_select.qrc)
meshlab_plugin(edit_select edit_select_srcs edit_select_moc_hdrs
  RCC edit_select_rcc
  )


# Edit slice - TODO - looks like this is incompatible with current
# vcglib...
set(edit_slice_srcs
  edit_slice/edit_slice_factory.cpp
  edit_slice/editslice.cpp
  edit_slice/slicedialog.cpp
  edit_slice/svgpro.cpp
  ../../external/vcglib/wrap/gui/trackball.cpp
  ../../external/vcglib/wrap/gui/trackmode.cpp
  )
set(edit_slice_moc_hdrs edit_slice/editslice.h)
set(edit_slice_uic edit_slice/slicedialog.ui edit_slice/svgpro.ui)
set(edit_slice_incdirs ../../external/vcglib)
meshlab_plugin(edit_slice edit_slice_srcs edit_slice_moc_hdrs
  INCLUDE_DIRS edit_slice_incdirs
  UIC edit_slice_uic
  IGNORE
  )

# Edit texture
set(edit_texture_srcs
  edit_texture/edit_texture_factory.cpp
  edit_texture/edittexture.cpp
  edit_texture/textureeditor.cpp
  edit_texture/renderarea.cpp
  ../../external/vcglib/wrap/gui/trackball.cpp
  ../../external/vcglib/wrap/gui/trackmode.cpp
  )
set(edit_texture_moc_hdrs edit_texture/edittexture.h)
set(edit_texture_uic edit_texture/textureeditor.ui)
set(edit_texture_incdirs ../../external/vcglib)
meshlab_plugin(edit_texture edit_texture_srcs edit_texture_moc_hdrs
  INCLUDE_DIRS edit_texture_incdirs
  UIC edit_texture_uic
  )

# *****************************
# ***** Decorator plugins *****
# *****************************




# **************************
# ***** Filter plugins *****
# **************************

# Filter aging
set(filter_aging_srcs filter_aging/filter_aging.cpp)
set(filter_aging_moc_hdrs filter_aging/filter_aging.h)
meshlab_plugin(filter_aging filter_aging_srcs filter_aging_moc_hdrs)

# Filter ao
set(filter_ao_srcs filter_ao/filter_ao.cpp)
set(filter_ao_moc_hdrs filter_ao/filter_ao.h)
set(filter_ao_rcc filter_ao/filter_ao.qrc)
meshlab_plugin(filter_ao filter_ao_srcs filter_ao_moc_hdrs
  RCC filter_ao_rcc
  )

# Filter autoalign
set(filter_autoalign_srcs
  filter_autoalign/filter_autoalign.cpp
  edit_align/align/AlignPair.cpp
  edit_align/align/Guess.cpp
  edit_align/point_matching_scale.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(filter_autoalign_moc_hdrs filter_autoalign/filter_autoalign.h)
set(filter_autoalign_incdirs ../../external)
meshlab_plugin(filter_autoalign filter_autoalign_srcs filter_autoalign_moc_hdrs
  INCLUDE_DIRS filter_autoalign_incdirs
  )

# Filter bnpts
set(filter_bnpts_srcs filter_bnpts/filter_bnpts.cpp)
set(filter_bnpts_moc_hdrs filter_bnpts/filter_bnpts.h)
meshlab_plugin(filter_bnpts filter_bnpts_srcs filter_bnpts_moc_hdrs)

# Filter camera
set(filter_camera_srcs filter_camera/filter_camera.cpp)
set(filter_camera_moc_hdrs filter_camera/filter_camera.h)
meshlab_plugin(filter_camera filter_camera_srcs filter_camera_moc_hdrs)

# Filter clean
set(filter_clean_srcs filter_clean/cleanfilter.cpp)
set(filter_clean_moc_hdrs filter_clean/cleanfilter.h)
meshlab_plugin(filter_clean filter_clean_srcs filter_clean_moc_hdrs)

# Filter colorize
set(filter_colorize_srcs filter_colorize/meshcolorize.cpp)
set(filter_colorize_moc_hdrs filter_colorize/meshcolorize.h)
meshlab_plugin(filter_colorize filter_colorize_srcs filter_colorize_moc_hdrs)

# Filter colorproc
set(filter_colorproc_srcs filter_colorproc/filter_colorproc.cpp)
set(filter_colorproc_moc_hdrs filter_colorproc/filter_colorproc.h)
meshlab_plugin(filter_colorproc filter_colorproc_srcs filter_colorproc_moc_hdrs)

# Filter color_projection
set(filter_color_projection_srcs filter_color_projection/filter_color_projection.cpp)
set(filter_color_projection_moc_hdrs filter_color_projection/filter_color_projection.h)
meshlab_plugin(filter_color_projection filter_color_projection_srcs filter_color_projection_moc_hdrs)

# Filter create
set(filter_create_srcs filter_create/filter_create.cpp)
set(filter_create_moc_hdrs filter_create/filter_create.h)
meshlab_plugin(filter_create filter_create_srcs filter_create_moc_hdrs)

# Filter csg
set(filter_csg_srcs filter_csg/filter_csg.cpp)
set(filter_csg_moc_hdrs filter_csg/filter_csg.h)
set(filter_csg_incdirs ${MPIR_INCLUDE_DIR})
meshlab_plugin(filter_csg filter_csg_srcs filter_csg_moc_hdrs
  INCLUDE_DIRS filter_csg_incdirs
  )

# Filter dirt
set(filter_dirt_srcs
  filter_dirt/filter_dirt.cpp
  filter_dirt/dirt_utils.cpp
  )
set(filter_dirt_moc_hdrs filter_dirt/filter_dirt.h)
meshlab_plugin(filter_dirt filter_dirt_srcs filter_dirt_moc_hdrs)

# Filter feature_alignment - TODO - broken
set(filter_feature_alignment_srcs
  filter_feature_alignment/filter_feature_alignment.cpp
  filter_mls/apss.cpp
  filter_mls/balltree.cpp
  filter_mls/apss.tpp
  filter_mls/mlssurface.tpp
  edit_pickpoints/pickedPoints.cpp
  )
set(filter_feature_alignment_moc_hdrs filter_feature_alignment/filter_feature_alignment.h)
set(filter_feature_alignment_incdirs ./filter_mls ../../external/ann/include)
meshlab_plugin(filter_feature_alignment filter_feature_alignment_srcs filter_feature_alignment_moc_hdrs
  INCLUDE_DIRS filter_feature_alignment_incdirs
  IGNORE
  )

# Filter fractal
set(filter_fractal_srcs filter_fractal/filter_fractal.cpp)
set(filter_fractal_moc_hdrs filter_fractal/filter_fractal.h)
meshlab_plugin(filter_fractal filter_fractal_srcs filter_fractal_moc_hdrs)

# Filter func
set(filter_func_srcs filter_func/filter_func.cpp)
set(filter_func_moc_hdrs filter_func/filter_func.h)
set(filter_func_incdirs ../../external/muparser/include)
set(filter_func_deps muParser)
meshlab_plugin(filter_func filter_func_srcs filter_func_moc_hdrs
  INCLUDE_DIRS filter_func_incdirs
  DEPS muParser
  )

# Filter image patch param
set(filter_img_patch_param_srcs
  filter_img_patch_param/filter_img_patch_param.cpp
  filter_img_patch_param/VisibleSet.cpp
  filter_img_patch_param/VisibilityCheck.cpp
  filter_img_patch_param/TexturePainter.cpp
  )
set(filter_img_patch_param_moc_hdrs filter_img_patch_param/filter_img_patch_param.h)
meshlab_plugin(filter_img_patch_param filter_img_patch_param_srcs filter_img_patch_param_moc_hdrs)

# Filter filter_isoparametrization
set(filter_isoparametrization_srcs filter_isoparametrization/filter_isoparametrization.cpp)
set(filter_isoparametrization_moc_hdrs filter_isoparametrization/filter_isoparametrization.h)
set(filter_isoparametrization_incdirs ../../external/levmar)
set(filter_isoparametrization_deps levmar)
add_definitions(-D_USE_OMP)
meshlab_plugin(filter_isoparametrization filter_isoparametrization_srcs filter_isoparametrization_moc_hdrs
  INCLUDE_DIRS filter_isoparametrization_incdirs
  DEPS levmar
  )

# Filter layer
set(filter_layer_srcs filter_layer/filter_layer.cpp)
set(filter_layer_moc_hdrs filter_layer/filter_layer.h)
meshlab_plugin(filter_layer filter_layer_srcs filter_layer_moc_hdrs)

# Filter measure
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/filter_measure/filter_measure.xml ${MESHLAB_BINARY_DIR}/${BIN_DIR}/filter_measure.xml COPYONLY)
set(filter_measure_srcs filter_measure/filter_measure.cpp)
set(filter_measure_moc_hdrs filter_measure/filter_measure.h)
meshlab_plugin(filter_measure filter_measure_srcs filter_measure_moc_hdrs)

# Filter meshing
set(filter_meshing_srcs
  filter_meshing/meshfilter.cpp
  filter_meshing/quadric_simp.cpp
  filter_meshing/quadric_tex_simp.cpp
  )
set(filter_meshing_moc_hdrs filter_meshing/meshfilter.h)
meshlab_plugin(filter_meshing filter_meshing_srcs filter_meshing_moc_hdrs)

# Filter mls
set(filter_mls_srcs
  filter_mls/apss.cpp
  filter_mls/balltree.cpp
  filter_mls/mlsplugin.cpp
  filter_mls/rimls.cpp
  filter_mls/apss.tpp
  filter_mls/mlssurface.tpp
  filter_mls/rimls.tpp
  )
set(filter_mls_moc_hdrs filter_mls/mlsplugin.h)
meshlab_plugin(filter_mls filter_mls_srcs filter_mls_moc_hdrs)

# Filter mutualinfoxml
set(filter_mutualinfoxml_srcs
  filter_mutualinfoxml/filter_mutualinfo.cpp
  filter_mutualinfoxml/alignset.cpp
  filter_mutualinfoxml/levmarmethods.cpp
  filter_mutualinfoxml/mutual.cpp
  filter_mutualinfoxml/parameters.cpp
  filter_mutualinfoxml/pointCorrespondence.cpp
  filter_mutualinfoxml/solver.cpp
  )
set(filter_mutualinfoxml_moc_hdrs filter_mutualinfoxml/filter_mutualinfo.h)
set(filter_mutualinfoxml_incdirs ../../external/levmar)
meshlab_plugin(filter_mutualinfoxml filter_mutualinfoxml_srcs filter_mutualinfoxml_moc_hdrs
  INCLUDE_DIRS filter_mutualinfoxml_incdirs
  )

# TODO - filter_photosynth

# Filter plymc
set(filter_plymc_srcs
  filter_plymc/filter_plymc.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(filter_plymc_moc_hdrs filter_plymc/filter_plymc.h)
meshlab_plugin(filter_plymc filter_plymc_srcs filter_plymc_moc_hdrs)

# Filter poisson
set(filter_poisson_srcs
  filter_poisson/filter_poisson.cpp
  filter_poisson/src/Factor.cpp
  filter_poisson/src/Geometry.cpp
  filter_poisson/src/MarchingCubes.cpp
  filter_poisson/src/MultiGridOctest.cpp
  )
set(filter_poisson_moc_hdrs filter_poisson/filter_poisson.h)
meshlab_plugin(filter_poisson filter_poisson_srcs filter_poisson_moc_hdrs)
if(NOT MSVC)
  set_property(TARGET filter_poisson APPEND PROPERTY COMPILE_FLAGS -fpermissive)
endif(NOT MSVC)

# Filter qhull
set(filter_qhull_srcs
  filter_qhull/filter_qhull.cpp
  filter_qhull/qhull_tools.cpp
  )
set(filter_qhull_moc_hdrs filter_qhull/filter_qhull.h)
set(filter_qhull_incdirs ../../external/qhull/src)
set(filter_qhull_deps qhull)
meshlab_plugin(filter_qhull filter_qhull_srcs filter_qhull_moc_hdrs
  INCLUDE_DIRS filter_qhull_incdirs
  DEPS qhull
  )


# Filter quality
set(filter_quality_srcs
  filter_quality/filterqualitymapper.cpp
  edit_quality/common/transferfunction.cpp
  edit_quality/common/util.cpp
  edit_quality/common/meshmethods.cpp
  )
set(filter_quality_moc_hdrs filter_quality/filterqualitymapper.h)
set(filter_quailty_incdirs edit_quality/common)
meshlab_plugin(filter_quality filter_quality_srcs filter_quality_moc_hdrs
  INCLUDE_DIRS filter_quality_incdirs
  )

# Filter sampling
set(filter_sampling_srcs filter_sampling/filter_sampling.cpp)
set(filter_sampling_moc_hdrs filter_sampling/filter_sampling.h)
meshlab_plugin(filter_sampling filter_sampling_srcs filter_sampling_moc_hdrs)

# Filter sdf
set(filter_sdf_srcs filter_sdf/filter_sdf.cpp)
set(filter_sdf_moc_hdrs filter_sdf/filter_sdf.h)
meshlab_plugin(filter_sdf filter_sdf_srcs filter_sdf_moc_hdrs IGNORE)

# Filter sdfgpu
set(filter_sdfgpu_srcs filter_sdfgpu/filter_sdfgpu.cpp)
set(filter_sdfgpu_moc_hdrs filter_sdfgpu/filter_sdfgpu.h)
meshlab_plugin(filter_sdfgpu filter_sdfgpu_srcs filter_sdfgpu_moc_hdrs IGNORE)

# Filter select
set(filter_select_srcs filter_select/meshselect.cpp)
set(filter_select_moc_hdrs filter_select/meshselect.h)
meshlab_plugin(filter_select filter_select_srcs filter_select_moc_hdrs)

# Filter ssynth
set(filter_ssynth_srcs filter_ssynth/filter_ssynth.cpp)
set(filter_ssynth_moc_hdrs filter_ssynth/filter_ssynth.h)
set(filter_ssynth_incdirs ./iox3d ../../external/structuresynth/ssynth)
meshlab_plugin(filter_ssynth filter_ssynth_srcs filter_ssynth_moc_hdrs
  INCLUDE_DIRS filter_ssynth_incdirs
  )

# Filter texture
set(filter_texture_srcs
  filter_texture/filter_texture.cpp
  ../../external/vcglib/wrap/ply/plylib.cpp
  )
set(filter_texture_moc_hdrs filter_texture/filter_texture.h)
meshlab_plugin(filter_texture filter_texture_srcs filter_texture_moc_hdrs)

# Filter trioptimize
set(filter_trioptimize_srcs filter_trioptimize/filter_trioptimize.cpp)
set(filter_trioptimize_moc_hdrs filter_trioptimize/filter_trioptimize.h)
meshlab_plugin(filter_trioptimize filter_trioptimize_srcs filter_trioptimize_moc_hdrs)

# Filter unsharp
set(filter_unsharp_srcs filter_unsharp/filter_unsharp.cpp)
set(filter_unsharp_moc_hdrs filter_unsharp/filter_unsharp.h)
meshlab_plugin(filter_unsharp filter_unsharp_srcs filter_unsharp_moc_hdrs)

# Filter zippering
set(filter_zippering_srcs filter_zippering/filter_zippering.cpp)
set(filter_zippering_moc_hdrs filter_zippering/filter_zippering.h)
meshlab_plugin(filter_zippering filter_zippering_srcs filter_zippering_moc_hdrs)

if(disabled_plugins)
  set(strlist "\n")
  foreach(pl ${disabled_plugins})
    set(strlist "${strlist}\n${pl}")
  endforeach(pl ${disabled_plugins})
  set(strlist "${strlist}\n")
  message("Note - the following standard plugins were not added: ${strlist}")
endif(disabled_plugins)

list(REMOVE_ITEM dir_plugins ${added_plugins})
list(REMOVE_ITEM dir_plugins ${disabled_plugins})
if(dir_plugins)
  set(strlist)
  foreach(pl ${dir_plugins})
    set(strlist "${strlist}\n${pl}")
  endforeach(pl ${dir_plugins})
  message(WARNING "The following standard plugins were not addressed by the build logic: ${strlist}")
endif(dir_plugins)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
