FROM ghcr.io/rest-for-physics/root:latest

ARG GARFIELD_VERSION=e0a9f171
ENV GARFIELD_VERSION=$GARFIELD_VERSION
ENV GARFIELD_INSTALL $INSTALL_DIR/garfieldpp

RUN git clone https://gitlab.cern.ch/garfield/garfieldpp.git /tmp/garfieldpp/source && \
    cd /tmp/garfieldpp/source && git reset --hard $GARFIELD_VERSION && \
    mkdir -p /tmp/garfieldpp/build && cd /tmp/garfieldpp/build && \
    cmake ../source/ -DCMAKE_INSTALL_PREFIX=$GARFIELD_INSTALL \
    -DWITH_EXAMPLES=OFF -DCMAKE_CXX_STANDARD=17 && \
    make -j8 install && \
    rm -rf /tmp/garfieldpp/build /tmp/garfieldpp/source

ENV CMAKE_PREFIX_PATH=$GARFIELD_INSTALL:$CMAKE_PREFIX_PATH
ENV HEED_DATABASE $GARFIELD_INSTALL/share/Heed/database
ENV LD_LIBRARY_PATH $GARFIELD_INSTALL/lib:$LD_LIBRARY_PATH
ENV ROOT_INCLUDE_PATH $GARFIELD_INSTALL/include:$ROOT_INCLUDE_PATH
