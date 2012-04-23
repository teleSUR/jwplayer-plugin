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

# Se requiere la ruta del bin de Flex SDK en el PATH
# PATH=ruta/al/flex/sdk:$PATH

### Variables específicas del script

openmultimedia_plugin_version='1.0'
debug=0

### Procesamiento de las opciones de linea de comandos

while [ $1 ]
do
    case $1 in

    '--uservars-file')
		shift
        OPENMULTIMEDIA_USERVARS_FILE="$1"
    ;;

    '--no-uservars-file')
        OPENMULTIMEDIA_USERVARS_FILE=''
    ;;

	### Custom command-line switches

	'--debug')
		debug=1
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

echo "Compilando Componente SWF (debug)"

mxmlc "./src/TelesurPlugin.as" \
-sp "./src/" \
-define=CONFIG::debug,true \
-o "./bin/telesur-debug.swf" \
-library-path+="./openmultimedia.jwplayer-plugin/lib" \
-library-path+="./openmultimedia.jwplayer-plugin/bin/openmultimedia-jwplugin-debug-1.0.swc" \
-load-externs "./openmultimedia.jwplayer-plugin/lib/jwplayer-5-classes.xml" \
-use-network=false
echo ""

echo "Compilando Componente SWF (release)"

mxmlc "./src/TelesurPlugin.as" \
-sp "./src/" \
-define=CONFIG::debug,false \
-o "./bin/telesur.swf" \
-library-path+="./openmultimedia.jwplayer-plugin/lib" \
-library-path+="./openmultimedia.jwplayer-plugin/bin/openmultimedia-jwplugin-1.0.swc" \
-load-externs "./openmultimedia.jwplayer-plugin/lib/jwplayer-5-classes.xml" \
-use-network=false

echo ""

echo "Compilacion terminada"

exit 0