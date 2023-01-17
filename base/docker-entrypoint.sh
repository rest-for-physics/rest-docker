#!/bin/bash

[ -f /usr/local/root/bin/thisroot.sh ] && source /usr/local/root/bin/thisroot.sh
[ -f /usr/local/garfieldpp/share/Garfield/setupGarfield.sh ] && source /usr/local/garfieldpp/share/Garfield/setupGarfield.sh
[ -f /usr/local/geant4/bin/geant4.sh ] && source /usr/local/geant4/bin/geant4.sh

exec "$@"
