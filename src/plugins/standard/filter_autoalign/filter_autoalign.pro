include (../../shared.pri)

HEADERS       += ../../../../vcglib/vcg/complex/algorithms/autoalign_4pcs.h \
                 ../../plugins/standard/edit_align/align/AlignPair.h \
                 ../../plugins/standard/edit_align/align/OccupancyGrid.h \
                 ../../common/filterparameter.h \
                 filter_autoalign.h

SOURCES       += filter_autoalign.cpp \
              ../../plugins/standard/edit_align/align/AlignPair.cpp \
              ../../plugins/standard/edit_align/align/Guess.cpp \
              ../../plugins/standard/edit_align/point_matching_scale.cpp \
              ../../../../vcglib/wrap/ply/plylib.cpp \

INCLUDEPATH += ../../external


TARGET        = filter_autoalign
macx:QMAKE_CXX=g++
