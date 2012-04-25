#!/bin/sh

# Script de construcción de proyectos de OpenMultimedia.
# Se puede utilizar la variable de entorno OPENMULTIMEDIA_USERVARS_FILE para
# indicar la ruta al archivo que contiene las variables requeridas con las rutas
# a herramientas y compiladores, así como el switch de línea de comandos:
# --uservars-file "<ruta-al-archivo>"
# El switch --no-uservars-file evita que se cargue cualquier archivo de "uservars",
# por ejemplo cuando este script se llama como parte de un proceso de build mayor
# o cuando las variables necesarias han sido agregadas  globalmente al sistema

### Rutas a herramientas requeridas

OPENMULTIMEDIA_USERVARS_FILE="$OPENMULTIMEDIA_USERVARS_FILE"

# Se requiere la ruta del bin de Flex SDK v3.6 en el PATH
# PATH=ruta/al/flex/sdk:$PATH

### Variables específicas del script

openmultimedia_plugin_submodule_path='./openmultimedia.jwplayer-plugin'
openmultimedia_plugin_version='1.0'

telesur_plugin_version='1.0'

debug=1
release=1

### Procesamiento de las opciones de linea de comandos
while [ $1 ]
do
    case $1 in
        ## Indica un archivo personalizado de UserVars
        '--uservars-file')
            shift
            OPENMULTIMEDIA_USERVARS_FILE="$1"
        ;;

        ## No carga archivo de UserVars
        '--no-uservars-file')
            OPENMULTIMEDIA_USERVARS_FILE=''
        ;;

        ## No genera el SWF de Pruebas
        '--no-debug')
            debug=0
        ;;

        ## No genera el SWF de Producción
        '--no-release')
            release=0
        ;;
    esac

    shift
done

### Carga de variables de usuario

if [ "$OPENMULTIMEDIA_USERVARS_FILE" ] && [ -r "$OPENMULTIMEDIA_USERVARS_FILE" ]
then
    echo "Cargando Variables de Usuario de: $OPENMULTIMEDIA_USERVARS_FILE"
    source "$OPENMULTIMEDIA_USERVARS_FILE"
	echo ""
fi

### Cambio de directorio de trabajo al directorio del script

DIR="$( cd "$( dirname "$0" )" && pwd )"
cd "$DIR"

### Instrucciones de construccion

if [ $debug -eq 1 ]
then
    echo "Compilando Componente SWF (debug)"

    mxmlc "./src/TelesurPlugin.as" \
    -source-path="./src/" \
    -source-path+="${openmultimedia_plugin_submodule_path}/src/" \
    -define=CONFIG::debug,true \
    -output "./bin/multimedia_telesur-${telesur_plugin_version}.debug.swf" \
    -library-path+="${openmultimedia_plugin_submodule_path}/lib" \
    -load-externs "${openmultimedia_plugin_submodule_path}/lib/jwplayer-5-classes.xml" \
    -use-network=false

    echo ""
fi

if [ $release -eq 1 ]
then
    echo "Compilando Componente SWF (release)"

    mxmlc "./src/TelesurPlugin.as" \
    -source-path="./src/" \
    -source-path+="${openmultimedia_plugin_submodule_path}/src/" \
    -define=CONFIG::debug,false \
    -output "./bin/multimedia_telesur-${telesur_plugin_version}.swf" \
    -library-path+="${openmultimedia_plugin_submodule_path}/lib" \
    -load-externs "${openmultimedia_plugin_submodule_path}/lib/jwplayer-5-classes.xml" \
    -use-network=false

    echo ""
fi

echo "Compilacion terminada"

exit 0