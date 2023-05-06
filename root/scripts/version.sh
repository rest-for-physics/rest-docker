#!/bin/bash

command -v root-config &> /dev/null && echo "- ROOT_VERSION: $(root-config --version)" || echo "- ROOT not found!"
command -v geant4-config &> /dev/null && echo "- GEANT4_VERSION: $(geant4-config --version)" || echo "- GEANT4 not found!"
test -v GARFIELD_VERSION && echo "- GARFIELD_VERSION: $GARFIELD_VERSION" || echo "- GARFIELD not found!"
