#!/bin/bash

# Propósito del script.
# Generar/agregar las nóminas de una empresa "Gaspachitos. S.A de C.V" de una 
# quincena en un archivo CSV.
# Los empleados tienen: nombre, id, tiempo de retardo y porcentaje de
# bonos (el sueldo es calculado por otro script). 
# Los únicos datos que varían después de ya tener el archivo creado son los
# retardos y el porcentaje de bono.

set -e
CSV_PATH="$HOME/Documentos/Proyectos/Paradigmas de programación/Gaspachitos/CSV"

NAMES=( "Aaron" "Juan" "Jorge" "George" "Samuel" "Uriel" "Brandon" )
ID=( "000001" "000002" "000003" "000004" "000005" "000006" "000007" )
SALARY=( 1000 1000 1000 1000 1000 1000 1000 )

main() {
    NUMBER=$(ls -lh "$CSV_PATH" | wc --lines)
    CSV_NAME="nómina${NUMBER}.csv"
    touch "${CSV_PATH}/${CSV_NAME}"


    for i in "${!NAMES[@]}"; do
        ARRIVAL_TIME=$(( ($RANDOM % 6001) - 3000 ))
        if [[ $ARRIVAL_TIME -le 0 ]]; then
            ARRIVAL_TIME=0
        fi
        BONUS=$(( $RANDOM % 41 ))
        echo "${NAMES[i]};${ID[i]};${SALARY[i]};${ARRIVAL_TIME};${BONUS}"
    done >> "${CSV_PATH}/${CSV_NAME}"

}

main
