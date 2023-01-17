#!/bin/bash

# thisREST.sh will source root, geant4 and garfieldpp
[ -f /usr/local/rest-for-physics/thisREST.sh ] && source /usr/local/rest-for-physics/thisREST.sh

exec "$@"
