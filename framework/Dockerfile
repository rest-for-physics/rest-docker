FROM ghcr.io/rest-for-physics/base:latest

ENV REST_PATH /usr/local/rest-for-physics

RUN git clone https://github.com/rest-for-physics/framework.git /tmp/rest-for-physics/source && \
    cd /tmp/rest-for-physics/source && python pull-submodules.py --latest:master && \
    mkdir /tmp/rest-for-physics/build && cd /tmp/rest-for-physics/build && \
    cmake /tmp/rest-for-physics/source -DCMAKE_INSTALL_PREFIX=${REST_PATH} -DREST_ALL_LIBS=ON -DREST_G4=ON && \
    make -j8 install && \
    rm -rf /tmp/rest-for-physics/source /tmp/rest-for-physics/build

ENV ROOT_INCLUDE_PATH $REST_PATH/include:$ROOT_INCLUDE_PATH
ENV PATH $REST_PATH/bin:$PATH
ENV LD_LIBRARY_PATH $REST_PATH/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH $REST_PATH/python-bindings:$PYTHONPATH

# Replace docker entrypoint to source rest-for-physics
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
