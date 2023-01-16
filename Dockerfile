FROM ubuntu:22.04 AS root

LABEL maintainer.name="Luis Antonio Obis Aparicio"
LABEL maintainer.email="luis.antonio.obis@gmail.com"

LABEL org.opencontainers.image.source="https://github.com/rest-for-physics/rest-docker"

ARG ROOT_BINARY=root_v6.26.10.Linux-ubuntu22-x86_64-gcc11.3.tar.gz
ARG INSTALL_DIR=/usr/local

ENV LANG=C.UTF-8

COPY dependencies /tmp/dependencies

RUN cat /tmp/dependencies/root /tmp/dependencies/general | sort | uniq > /tmp/dependencies/packages && \
    apt-get update -qq && \
    xargs -a /tmp/dependencies/packages apt-get install -y wget && \
    rm -rf /tmp/* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

RUN cd ${INSTALL_DIR} && \
    wget https://root.cern/download/${ROOT_BINARY} && \
    tar -xzf ${ROOT_BINARY} && \
    rm -f ${ROOT_BINARY}

ENV ROOTSYS ${INSTALL_DIR}/root
ENV PATH ${ROOTSYS}/bin:$PATH
ENV LD_LIBRARY_PATH ${ROOTSYS}/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH ${ROOTSYS}/lib:$PYTHONPATH

CMD ["/bin/bash"]

FROM root as root-garfield

ARG GARFIELD_VERSION=master
ENV GARFIELD_VERSION=${GARFIELD_VERSION}
RUN echo GARFIELD_VERSION: ${GARFIELD_VERSION}

RUN git clone https://gitlab.cern.ch/garfield/garfieldpp.git $INSTALL_DIR/garfieldpp/source && \
    cd $INSTALL_DIR/garfieldpp/source && git reset --hard ${GARFIELD_VERSION} && \
    mkdir -p $INSTALL_DIR/garfieldpp/build && cd $INSTALL_DIR/garfieldpp/build && \
    cmake ../source/ -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/garfieldpp \
    -DWITH_EXAMPLES=OFF -DCMAKE_CXX_STANDARD=17 && \
    make -j install && \
    rm -rf $INSTALL_DIR/garfieldpp/build $INSTALL_DIR/garfieldpp/source

ENV GARFIELD_INSTALL $INSTALL_DIR/garfieldpp
ENV CMAKE_PREFIX_PATH=$INSTALL_DIR/garfieldpp:$CMAKE_PREFIX_PATH
ENV HEED_DATABASE $INSTALL_DIR/garfieldpp/share/Heed/database
ENV LD_LIBRARY_PATH $INSTALL_DIR/garfieldpp/lib:$LD_LIBRARY_PATH
ENV ROOT_INCLUDE_PATH $INSTALL_DIR/garfieldpp/include:$ROOT_INCLUDE_PATH
