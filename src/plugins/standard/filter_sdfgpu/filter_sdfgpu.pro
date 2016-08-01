include (../../shared.pri)


INCLUDEPATH += ../../plugins/standard/render_radiance_scaling
DEPENDPATH += shaders

HEADERS       += filter_sdfgpu.h \
    filterinterface.h \
    ../../plugins/standard/render_radiance_scaling/gpuProgram.h \
    ../../plugins/standard/render_radiance_scaling/framebufferObject.h \
    ../../plugins/standard/render_radiance_scaling/gpuShader.h \
    ../../plugins/standard/render_radiance_scaling/textureParams.h \
    ../../plugins/standard/render_radiance_scaling/textureFormat.h \
    ../../plugins/standard/render_radiance_scaling/texture2D.h
SOURCES       += filter_sdfgpu.cpp \
    ../../plugins/standard/render_radiance_scaling/gpuProgram.cpp \
    ../../plugins/standard/render_radiance_scaling/framebufferObject.cpp \
    ../../plugins/standard/render_radiance_scaling/gpuShader.cpp \
    ../../plugins/standard/render_radiance_scaling/textureParams.cpp \
    ../../plugins/standard/render_radiance_scaling/textureFormat.cpp
TARGET        = filter_sdfgpu
TEMPLATE      = lib

CONFIG       += plugin

DEPENDPATH += ./shaders

RESOURCES += \
    filter_sdfgpu.qrc
