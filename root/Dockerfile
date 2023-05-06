FROM ubuntu:22.04

LABEL maintainer.name="Luis Antonio Obis Aparicio"
LABEL maintainer.email="luis.antonio.obis@gmail.com"

LABEL org.opencontainers.image.source="https://github.com/rest-for-physics/rest-docker"

ARG ROOT_BINARY=root_v6.28.02.Linux-ubuntu22-x86_64-gcc11.3.tar.gz
ENV INSTALL_DIR=/usr/local

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
