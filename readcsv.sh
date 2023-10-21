#!/bin/bash

# Propósito del script.
# Leer los archivos CSV y generar archivos en base a la
# información obtenida.

set -e

ROOT_PATH="/home/auriel/Documentos/Proyectos/Paradigmas de programación/Gaspachitos/test_folder"
BASE_PAYROLL_NAME="payroll"

main() {
    if [[ ! -d "$ROOT_PATH" ]]; then
        echo "El directorio \"$ROOT_PATH\" no existe, no se puede iniciar la"\
            "lectura de archivos."
        exit 1
    fi
    if [[ ! -d "$ROOT_PATH/csv" ]]; then
        echo "No existe el directorio \"csv\" dentro de \"$ROOT_PATH\"."
        echo "Pruebe ejecutando el script \"gencsv.sh\" primero."
        exit 1
    fi
    cd "$ROOT_PATH"
    mkdir -p "report"
    for FILE in csv/"${BASE_PAYROLL_NAME}"*.csv; do
        mapfile -t PAYROLL_DATA < "${FILE}"
        PAYROLL_FOLDER="report/$(basename "${FILE}" .csv)"
        mkdir -p "$PAYROLL_FOLDER"
        for ROW in "${PAYROLL_DATA[@]}"; do
            mapfile -t -d ";" EMPLOYEE_DATA < <(echo -n "${ROW}")
            EMPLOYEE=${EMPLOYEE_DATA[0]}
            ID=${EMPLOYEE_DATA[1]}
            BASE_SALARY=${EMPLOYEE_DATA[2]}
            LATE_TIME=${EMPLOYEE_DATA[3]}
            BONUS_PERCENTAGE=${EMPLOYEE_DATA[4]}
            # Fórmula de descuento del sueldo:
            # salario_base*minutos_tarde*0.05, así se descuenta 1% por dos
            # minutos de atraso.
            DISCOUNT=$(awk "BEGIN {print $BASE_SALARY*0.$LATE_TIME/60*0.05}")
            BONUS=$(awk "BEGIN {print $BASE_SALARY*0.$BONUS_PERCENTAGE}")
            TOTAL=$(awk "BEGIN {print $BASE_SALARY-$DISCOUNT+$BONUS}")
            EMPLOYEE_FILE="$PAYROLL_FOLDER/$EMPLOYEE.txt"
            printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' \
                "nombre:$EMPLOYEE" \
                "id:$ID" \
                "retardo:$LATE_TIME" \
                "porcentaje_bono:$BONUS_PERCENTAGE" \
                "subtotal_retardo:$DISCOUNT" \
                "subtotal_bono:$BONUS" \
                "sueldo:$BASE_SALARY" \
                "total:$TOTAL" > "$EMPLOYEE_FILE"
        done
    done
}

main
