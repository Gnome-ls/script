#!/bin/bash
#Despues de escoger en que directorio se instalará el monitor
#mnt puede cambiar por otra que tenga mayor capacidad de memor$
cd /home/jccv/
var1=$(pwd)
echo "estas en ====> $var1"

function crea_directorio {
        echo "creando carpeta"
        mkdir ManageEngine
}

function ManageEngine_descarga {
        echo "====> Descargando...."
        wget https://www.manageengine.com/products/applications_manager/54974026/ManageEngine_ApplicationsManager_64bit.bin
        chmod +x ManageEngine_ApplicationsManager_64bit.bin
}

function archivoPassword {
cat > password.txt <<- EOF
appmanager
EOF
}

function renombrarAmdb {
        mv amdb amdb_old
        echo "amdb renombrado"
}

#Preguntamos si existe la carpeta
if [ -d /home/jccv/ManageEngine ]; then
#si existe muestra el mensaje
        echo "====> Existe la carpeta ManageEngine"
#si no existe la crea y muestra mensaje de creado
else
    	crea_directorio
fi

cd /home/jccv/ManageEngine
direc=$(pwd)
echo "estas en ====> $direc"
#Salimos hasta la reiz
cd /home/jccv/Escritorio/script-clon/script/SIGI
# Ruta de donde se encuentre el script y donde se descargará e$
cd /home/jccv/Descargas
ruta=$(pwd)
echo "estas en ====> $ruta"
#Enlace de descarga


if [ -f ManageEngine_ApplicationsManager_64bit.bin ]; then
        echo "====> Ya se encuentra descargado Manage Engine"
else
        ManageEngine_descarga
fi

if [ -d /home/jccv/ManageEngine/AppManager14 ]; then
        echo "Existe la carpeta AppManager14 "
else
        echo "Instalando"
        tmp=/home/jccv/ManageEngine
        echo -e "\n\n\n\n\n\n\n\n\ny\n1\n1\n1\n\n\n\n1\n$tmp\ny\n\nn\n\n\n\n" | ./ManageEngine_ApplicationsManager_64bit.bin -i console
fi
cd /home/jccv/
sleep 3s
var2=$(pwd)
echo "estas en ====> $var2"
cd /home/jccv/ManageEngine/AppManager14
var3=$(pwd)
echo "estas en ====> $var3"
ls
echo "Iniciando aplicación"
sleep 30s
nohup sh startApplicationsManager.sh &
sleep 30s
#echo "c"
cd /home/jccv/ManageEngine/AppManager14/working/bin
var4=$(pwd)
echo "estas en ====> $var4"
ls
cd /home/jccv/ManageEngine/AppManager14/working/bin
if [ -f /home/jccv/ManageEngine/AppManager14/working/bin/password.txt ]; then
        echo "====> El archivo password.txt ya se encuentra"
else
        echo "====> Creando el archivo password.txt ..."
        archivoPassword
fi

ls
cd /home/jccv/ManageEngine/AppManager14/
var5=$(pwd)
echo "estas en ====> $var5"
ls
cd conf/
var6=$(pwd)
echo "estas en ====> $var6"
ls
sed -i 's/am.db.port=15432/am.db.port=15434/g' "AMServer.properties"
echo "AMServer modificado"
cd /home/jccv/ManageEngine/AppManager14/
var8=$(pwd)
echo "estas en ====> $var8"
echo "Bajar aplicación"
sleep 30s
./shutdownApplicationsManager.sh -force
sleep 30s
cd /home/jccv/ManageEngine/AppManager14/working/pgsql/data/
var7=$(pwd)
echo "estas en ====> $var7"

if [ -f amdb_old ]; then
        echo "=====> ya está amdb_old"
else
        renombrarAmdb
fi

cd /home/jccv/ManageEngine/AppManager14/
var9=$(pwd)
echo "estas en ====> $var9"
rm -rf logs
echo "carpeta logs eliminada"
mkdir logs
echo "carpeta logs creada"
cd /home/jccv/ManageEngine/AppManager14/
var10=$(pwd)
nohup sh startApplicationsManager.sh > nohup.out &
sleep 15m
file=/home/jccv/ManageEngine/AppManager14/nohup.out
while read line ; do 
	#echo -e "$line\n" 
	result=$(grep "9090" nohup.out)
	echo "DEBUG: Resultado encontrado $result"
	if [ -z "$result" ]; then 
		echo "Completo..."
	break
	fi
done < "$file"
cd /home/jccv/Escritorio/script-clon/script/SIGI
./configuracion-monitor.sh 
