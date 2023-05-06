FROM ghcr.io/rest-for-physics/root-garfield:latest

ARG GEANT4_VERSION=v11.0.4

RUN ls -lht $INSTALL_DIR

COPY dependencies /tmp/dependencies

RUN apt-get update -qq && \
    xargs -a /tmp/dependencies/geant4 apt-get install -y && \
    rm -rf /tmp/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Geant4/geant4.git /tmp/geant4/source --branch=${GEANT4_VERSION} && \
    cd /tmp/geant4/source && \
    mkdir -p /tmp/geant4/build && cd /tmp/geant4/build && \
    cmake ../source/ -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/geant4 -DCMAKE_CXX_STANDARD=17 \
    -DGEANT4_INSTALL_DATA=ON -DGEANT4_USE_GDML=ON -DGEANT4_USE_QT=ON -DGEANT4_INSTALL_EXAMPLES=OFF \
    -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_RAYTRACER_X11=ON && \
    make -j8 install && \
    rm -rf /tmp/geant4/build /tmp/geant4/source

ENV PATH $INSTALL_DIR/geant4/bin:$PATH
ENV LD_LIBRARY_PATH $INSTALL_DIR/geant4/lib:$LD_LIBRARY_PATH
