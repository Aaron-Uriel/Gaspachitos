#!/bin/bash

# Propósito del programa. Leer los archivos CSV y generar archivos en base a la
# información obtenida.

ROOT_PATH="$HOME/Documentos/Proyectos/Paradigmas de programación/Gaspachitos/"

main() {
    cd "$ROOT_PATH"
    mkdir -p report
    FILES=( $(ls "CSV" | awk 'BEGIN { FS="."; ORS=" " } /.csv/ { print $1 }') )
    for FILE in "${FILES[@]}"; do
        mkdir -p "report/$FILE"
        PEOPLE=( $(awk -F ";" 'BEGIN { ORS=" " } {print $1}' "CSV/${FILE}.csv") )
        for PERSON in "${PEOPLE[@]}"; do
            touch "report/${FILE}/${PERSON}.txt"
        done
    done
}

main
