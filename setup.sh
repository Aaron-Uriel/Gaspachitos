#!/bin/bash

# Propósito del programa.
# Ajustas las carpetas y el nombre de los archivos de las nóminas.

set -e

ROOT_PATH="$PWD/test_folder"
mkdir -p "$ROOT_PATH"
sed -i "s@ROOT_PATH=.*@ROOT_PATH=\"$ROOT_PATH\"@" gencsv.sh readcsv.sh rcui.sh
echo "Adaptado el proyecto para tabajar en la carpeta $ROOT_PATH"
