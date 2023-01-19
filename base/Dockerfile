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

# Entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN echo "source docker-entrypoint.sh" >> ~/.bashrc

# Version script
COPY scripts/version.sh /usr/local/bin/version.sh
RUN chmod +x /usr/local/bin/version.sh

WORKDIR /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]

FROM root as root-garfield

ARG GARFIELD_VERSION=e0a9f171
ENV GARFIELD_VERSION=${GARFIELD_VERSION}
ENV GARFIELD_INSTALL $INSTALL_DIR/garfieldpp

RUN git clone https://gitlab.cern.ch/garfield/garfieldpp.git /tmp/garfieldpp/source && \
    cd /tmp/garfieldpp/source && git reset --hard ${GARFIELD_VERSION} && \
    mkdir -p /tmp/garfieldpp/build && cd /tmp/garfieldpp/build && \
    cmake ../source/ -DCMAKE_INSTALL_PREFIX=$GARFIELD_INSTALL \
    -DWITH_EXAMPLES=OFF -DCMAKE_CXX_STANDARD=17 && \
    make -j8 install && \
    rm -rf /tmp/garfieldpp/build /tmp/garfieldpp/source

ENV CMAKE_PREFIX_PATH=$GARFIELD_INSTALL:$CMAKE_PREFIX_PATH
ENV HEED_DATABASE $GARFIELD_INSTALL/share/Heed/database
ENV LD_LIBRARY_PATH $GARFIELD_INSTALL/lib:$LD_LIBRARY_PATH
ENV ROOT_INCLUDE_PATH $GARFIELD_INSTALL/include:$ROOT_INCLUDE_PATH

FROM root-garfield as root-geant4-garfield

ARG GEANT4_VERSION=v11.0.3

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
    -DGEANT4_INSTALL_DATA=ON -DGEANT4_USE_GDML=ON -DGEANT4_USE_QT=ON -DGEANT4_INSTALL_EXAMPLES=OFF && \
    make -j8 install && \
    rm -rf /tmp/geant4/build /tmp/geant4/source

ENV PATH $INSTALL_DIR/geant4/bin:$PATH
ENV LD_LIBRARY_PATH $INSTALL_DIR/geant4/lib:$LD_LIBRARY_PATH
