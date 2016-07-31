include (../../shared.pri)

HEADERS       += filter_qhull.h \
		qhull_tools.h 

SOURCES       += filter_qhull.cpp \ 
		qhull_tools.cpp 

HEADERS += 	../../external/qhull/src/geom.h \
		../../external/qhull/src/io.h \
		../../external/qhull/src/mem.h \
		../../external/qhull/src/merge.h \
		../../external/qhull/src/poly.h \
		../../external/qhull/src/qhull.h \
		../../external/qhull/src/qset.h \
		../../external/qhull/src/stat.h \
		../../external/qhull/src/user.h 

SOURCES +=	../../external/qhull/src/geom.c \
		../../external/qhull/src/geom2.c \
		../../external/qhull/src/global.c \
		../../external/qhull/src/io.c \
		../../external/qhull/src/mem.c \
		../../external/qhull/src/merge.c \
		../../external/qhull/src/poly.c \
		../../external/qhull/src/poly2.c \
		../../external/qhull/src/qconvex.c \
		../../external/qhull/src/qhull.c \
		../../external/qhull/src/qset.c \
		../../external/qhull/src/stat.c \
		../../external/qhull/src/user.c 

TARGET        = filter_qhull