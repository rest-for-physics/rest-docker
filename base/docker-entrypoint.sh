#!/bin/bash

[ -f /usr/local/root/install/bin/thisroot.sh ] && source /usr/local/root/install/bin/thisroot.sh
[ -f /usr/local/garfieldpp/install/share/Garfield/setupGarfield.sh ] && source /usr/local/garfieldpp/install/share/Garfield/setupGarfield.sh
[ -f /usr/local/geant4/install/bin/geant4.sh ] && source /usr/local/geant4/install/bin/geant4.sh

exec "$@"
