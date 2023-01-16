FROM rest-for-physics/base:latest

ARG INSTALL_DIR=/rest

RUN git clone https://github.com/rest-for-physics/framework.git $INSTALL_DIR/rest-for-physics/source && \
    cd $INSTALL_DIR/rest-for-physics/source && python pull-submodules.py --latest:master && \
    mkdir ../build && cd ../build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DREST_ALL_LIBS=ON -DREST_G4=ON && \
    make -j8 install && \
    rm -rf $INSTALL_DIR/rest-for-physics/source $INSTALL_DIR/rest-for-physics/build
