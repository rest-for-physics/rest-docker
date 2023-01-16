FROM ubuntu:22.04 AS root

LABEL maintainer.name="Luis Antonio Obis Aparicio"
LABEL maintainer.email="luis.antonio.obis@gmail.com"

LABEL org.opencontainers.image.source="https://github.com/rest-for-physics/rest-docker"

ARG ROOT_BINARY=root_v6.26.10.Linux-ubuntu22-x86_64-gcc11.3.tar.gz
ARG INSTALL_DIR=/usr/local

ENV LANG=C.UTF-8

COPY dependencies /tmp/dependencies

RUN apt-get update -qq && \
    xargs -a /tmp/dependencies/root apt-get install -y wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

RUN cd ${INSTALL_DIR} && \
    wget https://root.cern/download/${ROOT_BINARY} && \
    tar -xzf ${ROOT_BINARY} && \
    rm -f ${ROOT_BINARY}

RUN rm -rf /tmp/*

ENV ROOTSYS ${INSTALL_DIR}/root
ENV PATH ${ROOTSYS}/bin:$PATH
ENV LD_LIBRARY_PATH ${ROOTSYS}/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH ${ROOTSYS}/lib:$PYTHONPATH

CMD ["/bin/bash"]
