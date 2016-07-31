#!/bin/sh
mkdir src
mkdir src/external

find vcglib -type f |xargs chmod -x
find vcglib -name \*.svn |xargs rm -rf
mv vcglib src/external/

# No include updates appear needed
mkdir src/external/ann
mv meshlab/src/external/ann*/* src/external/ann
rm -rf meshlab/src/external/ann*

# No include updates appear needed
mkdir src/external/bzip2
mv meshlab/src/external/bzip2*/* src/external/bzip2
rm -rf meshlab/src/external/bzip2*

mv meshlab/src/external/CoMISo src/external/

# No include updates appear needed
mkdir src/external/glew
rm -rf meshlab/src/external/glew-1.5.1
mv meshlab/src/external/glew*/* src/external/glew
rm -rf meshlab/src/external/glew*

mv meshlab/src/external/GotoBLAS2 src/external/

# TODO - why is this needed?
mv meshlab/src/external/inc src/external/

# TODO - is jhead even used?
mkdir src/external/jhead
mv meshlab/src/external/jhead*/* src/external/jhead
rm -rf meshlab/src/external/jhead*

# levmar rename implies updates
mkdir src/external/levmar
mv meshlab/src/external/levmar*/* src/external/levmar
rm -rf meshlab/src/external/levmar*
find meshlab -type f -exec perl -0777 -pi -e 's/levmar-2.3/levmar/g' {} \;

# TODO - why is this needed?
mv meshlab/src/external/lib src/external/

# No include updates appear needed
mkdir src/external/lib3ds
mv meshlab/src/external/lib3ds*/* src/external/lib3ds
rm -rf meshlab/src/external/lib3ds*

# No include updates appear needed
mkdir src/external/maxflow
mv meshlab/src/external/maxflow*/* src/external/maxflow
rm -rf meshlab/src/external/maxflow*

# No include updates appear needed
mkdir src/external/muparser
rm -rf meshlab/src/external/muparser_v130
mv meshlab/src/external/muparser*/* src/external/muparser
rm -rf meshlab/src/external/muparser*

mv meshlab/src/external/newuoa src/external/

# No include updates appear needed
mkdir src/external/ode
mv meshlab/src/external/ode*/* src/external/ode
rm -rf meshlab/src/external/ode*

# No include updates appear needed
mkdir src/external/OpenCTM
mv meshlab/src/external/OpenCTM*/* src/external/OpenCTM
rm -rf meshlab/src/external/OpenCTM*

mv meshlab/src/external/openkinect src/external/

# qhull rename implies updates
mkdir src/external/qhull
mv meshlab/src/external/qhull*/* src/external/qhull
rm -rf meshlab/src/external/qhull*
find meshlab -type f -exec perl -0777 -pi -e 's/qhull-2003.1/qhull/g' {} \;

# No include updates appear needed
mkdir src/external/qtsoap
mv meshlab/src/external/qtsoap*/* src/external/qtsoap
rm -rf meshlab/src/external/qtsoap*

# No include updates appear needed
mkdir src/external/structuresynth
rm -rf meshlab/src/external/structuresynth
mv meshlab/src/external/structuresynth*/* src/external/structuresynth
rm -rf meshlab/src/external/structuresynth*

# No include updates appear needed
mkdir src/external/tsai
mv meshlab/src/external/tsai*/* src/external/tsai
rm -rf meshlab/src/external/tsai*

## Make sure none of the files are executable
find meshlab -type f -exec chmod -x {} \;