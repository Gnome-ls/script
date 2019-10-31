#!/bin/bash

cd /home/jccv/ManageEngine/AppManager14
./shutdownApplicationsManager.sh -force | tee forzarCierre.txt 

if grep "All the related process are terminated" forzarCierre.txt; then

	cd 
	ls=$(ls)
	echo "$ls" | tee listado.txt 

	if grep "Change ManageEngine Applications"  listado.txt ; then 
		CME=$(find -iname "Change ManageEngine Applications*") 
		echo "$CME" | tee listadoRaiz.txt
		sed -i '/_ManageEngine*/d' "listadoRaiz.txt"
		sed -i 's%./%%g' "listadoRaiz.txt"
		eliminar=$(cat listadoRaiz.txt)
		echo "ARCHIVO A ELIMINAR >>>>>>>>>>>>>>>> $eliminar"
		rm -rf "$eliminar"
	else 
		echo "El archivo no se encuentra"
	fi

	if [ -d /home/jccv/ManageEngine/AppManager14 ]; then 
		echo "la carpeta existe y debe eliminarse"
		cd /home/jccv/
		var1=$(pwd)
		echo "			$var1"
		rm -rf ManageEngine
	else
		echo "la carpeta no existe"
		cd /home/jccv/Escritorio/script-clon/script/SIGI
		SIGI=$(pwd)
		echo "Estas en el directorio $SIGI"
		./instalacionMonitor.sh
	fi
	cd /home/jccv/Escritorio/script-clon/script/SIGI
	./instalacionMonitor.sh
else

	echo "El puerto aun no se cierra o es la primera vez que se instala"
	cd
	rm -rf ManageEngine
	cd /home/jccv/Escritorio/script-clon/script/SIGI
	./instalacionMonitor.sh
fi

