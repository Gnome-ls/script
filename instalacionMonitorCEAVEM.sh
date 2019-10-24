#!/bin/bash
#Despues de escoger en que directorio se instalará el monitor
#mnt puede cambiar por otra que tenga mayor capacidad de memor$
cd /home/engine/
var1=$(pwd)
echo "estas en ====> $var1"

function crea_directorio {
        echo "creando carpeta"
        echo -e "evo100518\n" | sudo mkdir ManageEngine
}

function ManageEngine_descarga {
        echo "====> Descargando...."
        sudo wget https://www.manageengine.com/products/applications_manager/54974026/ManageEngine_ApplicationsManager_64bit.bin
        sudo chmod +x ManageEngine_ApplicationsManager_64bit.bin
}

function archivoPassword {
sudo cat > password.txt <<- EOF
appmanager
EOF
}

function renombrarAmdb {
        sudo mv amdb amdb_old
        echo "amdb renombrado"
}

#Preguntamos si existe la carpeta
if [ -d /home/engine/ManageEngine ]; then
#si existe muestra el mensaje
        echo "====> Existe la carpeta ManageEngine"
#si no existe la crea y muestra mensaje de creado
else
    	crea_directorio
fi

cd /home/engine/ManageEngine
direc=$(pwd)
echo "estas en ====> $direc"
#Salimos hasta la reiz
cd /home/engine/
# Ruta de donde se encuentre el script y donde se descargará e$
cd /home/engine/Descargas
ruta=$(pwd)
echo "estas en ====> $ruta"
#Enlace de descarga


if [ -f ManageEngine_ApplicationsManager_64bit.bin ]; then
        echo "====> Ya se encuentra descargado Manage Engine"
else
        ManageEngine_descarga
fi

if [ -d /home/engine/ManageEngine/AppManager14 ]; then
        echo "Existe la carpeta AppManager14 "
else
        echo "Instalando"
        tmp=/home/engine/ManageEngine
        echo -e "\n\n\n\n\n\n\n\n\ny\n1\n1\n1\n\n\n\n1\n$tmp\ny\n\nn\n\n\n\n" | sudo ./ManageEngine_ApplicationsManager_64bit.bin -i console
fi
cd /home/engine/
sleep 3s
var2=$(pwd)
echo "estas en ====> $var2"
cd /home/engine/ManageEngine/AppManager14
var3=$(pwd)
echo "estas en ====> $var3"
ls
echo "Iniciando aplicación"
sleep 30s
sudo nohup sh startApplicationsManager.sh &
sleep 30s
#echo "c"
cd /home/engine/ManageEngine/AppManager14/working/bin
var4=$(pwd)
echo "estas en ====> $var4"
ls
cd /home/engine/ManageEngine/AppManager14/working/bin
if [ -f /home/engine/ManageEngine/AppManager14/working/bin/password.txt ]; then
        echo "====> El archivo password.txt ya se encuentra"
else
        echo "====> Creando el archivo password.txt ..."
        archivoPassword
fi

ls
cd /home/engine/ManageEngine/AppManager14/
var5=$(pwd)
echo "estas en ====> $var5"
ls
cd conf/
var6=$(pwd)
echo "estas en ====> $var6"
ls
sudo sed -i 's/am.db.port=15432/am.db.port=15434/g' "AMServer.properties"
echo "AMServer modificado"
cd /home/engine/ManageEngine/AppManager14/
var8=$(pwd)
echo "estas en ====> $var8"
echo "Bajar aplicación"
sleep 30s
sudo ./shutdownApplicationsManager.sh -force
sleep 30s
cd /home/engine/ManageEngine/AppManager14/working/pgsql/data/
var7=$(pwd)
echo "estas en ====> $var7"

if [ -f amdb_old ]; then
        echo "=====> ya está amdb_old"
else
        renombrarAmdb
fi

cd /home/engine/ManageEngine/AppManager14/
var9=$(pwd)
echo "estas en ====> $var9"
sudo rm -rf logs
echo "carpeta logs eliminada"
sudo mkdir logs
echo "carpeta logs creada"
cd /home/engine/ManageEngine/AppManager14/
var10=$(pwd)
sudo nohup sh startApplicationsManager.sh &
tail -F nohup.out
echo "estas en ====> $var10"
#cd /home/engine/
#var11=$(pwd)
#echo "estas en ====> $var11"


