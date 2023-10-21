# Gaspachitos.
## Descripción.
Primer proyecto de Laboratorio de paradigmas de progrmación.

## Elementos del proyecto.
- `setup.sh` adapta el proyecto para trabajar en la carpeta actual.
- `gencsv.sh` genera archivos csv conteniendo datos de los empleados inclyendo
nombres, sueldo base, tiempo de retardo total, bono. Todo en el intervalo de
una quincena.
- `readcsv.sh` interpreta los datos de los archivos csv, genera carpetas y
archivos de texto más legibles en base a ellos.
- `rcui.sh` es la interfaz con la cual se puede navegar por los archivos
generados por `readcsv.sh`.

## Uso.
Para el uso de los programas primero ejecutar `setup.sh` y luego `gencsv.sh`.
`rcui.sh` necesita que se haya ejecutado `readcsv.sh` anteriormente.
