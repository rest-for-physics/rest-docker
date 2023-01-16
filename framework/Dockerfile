FROM rest-for-physics/base:latest

RUN git clone https://github.com/rest-for-physics/framework.git /tmp/rest-for-physics/source && \
    cd /tmp/rest-for-physics/source && python pull-submodules.py --latest:master && \
    mkdir ../build && cd ../build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/rest-for-physics -DREST_ALL_LIBS=ON -DREST_G4=ON && \
    make -j8 install && \
    rm -rf /tmp/rest-for-physics/source /tmp/rest-for-physics/build
