#!/bin/bash

# Propósito del programa.
# Servir como interfaz de usuario para la lectura de nóminas, en caso de no
# haber sido creados los archivos de texto (no csv) conteniendo la información
# se llamará al script que los crea.

set -e

ROOT_PATH="/home/auriel/Documentos/Proyectos/Paradigmas de programación/Gaspachitos/test_folder"
BASE_PAYROLL_NAME="payroll"

main() {
    if [[ ! -d "$ROOT_PATH" ]]; then
        echo "El directorio \"$ROOT_PATH\" no existe, no se puede iniciar la"\
            "lectura de archivos."
        exit 1
    fi
    if [[ ! -d "$ROOT_PATH/report" ]]; then
        echo "No existe el directorio \"report\" dentro de \"$ROOT_PATH\"."
        echo "Pruebe ejecutando el script \"readcsv.sh\" primero."
        exit 1
    fi
    if [[ ! -d "$ROOT_PATH/report/${BASE_PAYROLL_NAME}0" ]]; then
        echo "Se necesita haber generado al menos una quincena para usar"\
            "este programa."
        exit 1
    fi

    cd "$ROOT_PATH"
    while true; do
        echo "Login."
        echo "Para iniciar como administrador pruebe con usuario y"\
            "constraseña \"admin\"."
        read -r -p 'Usuario: ' USER
        read -r -s -p 'Constraseña: ' PASSWORD
        echo

        if [[ "$USER" = "admin" && "$PASSWORD" = "admin" ]]; then
            break
        else
            echo "Contraseña incorrecta."
        fi
    done

    echo "Inició sesión con éxito."
    mapfile -t EMPLOYEES < <(find "report/${BASE_PAYROLL_NAME}0" -type f \
        -printf "%f\n" | awk -F "." '{print $1}')
    EMPLOYEES_COUNT=${#EMPLOYEES[@]}
    PAYROLLS_COUNT=$(find "report/" -type d \
        -name "${BASE_PAYROLL_NAME}*" | wc --lines)
    while true; do
        echo "Total de nóminas: ${EMPLOYEES_COUNT}"
        echo "Total de quincenas generadas: ${PAYROLLS_COUNT}"
        echo "¿Qué desea hacer?:"
        printf '%s\n%s\n' \
            "1) Listar información de una quincena en específico." \
            "2) Información de un empleado."
        read -r -p "Opción: " OPT
        case $OPT in
            1)
                echo "Se tienen ${PAYROLLS_COUNT} quincenas"
                read -r -p "Quincena [0-$(( PAYROLLS_COUNT-1 ))]: " INDEX
                if (( INDEX >= PAYROLLS_COUNT )) || (( INDEX < 0)); then
                    echo "La quincena $INDEX no existe."
                    read -r
                    break
                fi
                echo "Imprimiendo información de todos los empleados en"\
                    "la quincena $INDEX."
                for FILE in report/"$BASE_PAYROLL_NAME$INDEX"/*; do
                    cat "$FILE"
                    echo
                done | less
                ;;
            2)
                echo "Se tienen ${PAYROLLS_COUNT} quincenas"
                echo "Los empleados son: ${EMPLOYEES[*]}"
                read -r -p "Nombre del empleado: " NAME
                read -r -p "Quincena [0-$(( PAYROLLS_COUNT-1))]: " INDEX
                REGEX="\<$NAME\>"
                if [[ ${EMPLOYEES[*]} =~ $REGEX ]]; then
                    less "report/$BASE_PAYROLL_NAME$INDEX/$NAME.txt" 
                else
                    echo "El empleado $NAME no existe."
                    read -r
                fi
                ;;
        esac

    done
}

main
