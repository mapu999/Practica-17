#!/bin/bash
 
nomscript=$0   # $0 es el nom del programa
 
function usage () {
   cat <<EOF
Usage: nomscript [-u usuari] [-h hostname] [-t]
   -u   usuari de la base de dades (obligatori)
   -h   hostname on es connectarà (obligatori
   -p   port (no obligatori ja que per defecte és 3306, però si existeix ha de ser un numero superior a 1024 i inferior o igual a 65535)
   -t   no es connecta,  només comprova connexió
EOF
exit 1
}

 
while getopts ":u:h:p:t:" opt; do
    case "${opt}" in
        u)
			u=${OPTARG}
			;;
        h)
            h=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            puerto=3306
            if
            [ ${OPTARG} -le "1024" || ${OPTARG} -gt "65535" ]; then
				echo "No esta en el rango de puertos"
			fi
            ;;
        t)
            t=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))
 
# Check required switches exist
if [ -z "${u}" ] || [ -z "${h}" ]; then
	usage
fi
