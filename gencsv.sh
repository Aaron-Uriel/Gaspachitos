#!/bin/bash

# Propósito del script.
# Generar las nóminas de una empresa "Gaspachitos. S.A de C.V" de una 
# quincena en un archivo CSV.
# Los empleados tienen: nombre, id, sueldo base, tiempo de retardo y 
# porcentaje de bonos. 
# Los únicos datos que varían después de ya tener el archivo creado son los
# retardos y el porcentaje de bono.

set -e
ROOT_PATH="/home/auriel/Documentos/Proyectos/Paradigmas de programación/Gaspachitos/test_folder"
BASE_PAYROLL_NAME="payroll"

EMPLOYEES=( "Aaron" "Juan" "Jorge" "Julia" "Fernanda" "Uriel" "Brandon" \
    "Felipe" "Julio" )
declare -A ID SALARY
for i in "${!EMPLOYEES[@]}"; do
    ID[${EMPLOYEES[i]}]=$(printf '%06d' "$i")
    SALARY[${EMPLOYEES[i]}]="3500"
done

rand() {
    echo "$(( RANDOM % (${2}-${1}+1) + ${1} ))"
}

main() {
    cd "$ROOT_PATH"
    mkdir -p "csv"
    NUMBER=$(find csv/ -name "${BASE_PAYROLL_NAME}*.csv" | wc --lines)
    CSV_NAME="${BASE_PAYROLL_NAME}${NUMBER}.csv"
    touch "csv/${CSV_NAME}"

    for EMPLOYEE in "${EMPLOYEES[@]}"; do
        ARRIVAL_TIME=$(rand -2000 3000)
        [[ $ARRIVAL_TIME -le 0 ]] && ARRIVAL_TIME=0
        BONUS=$(rand -30 40)
        [[ $BONUS -le 0 ]] && BONUS=0
        echo "${EMPLOYEE};${ID[${EMPLOYEE}]};${SALARY[${EMPLOYEE}]};${ARRIVAL_TIME};${BONUS}"
    done >> "csv/${CSV_NAME}"

}

main
