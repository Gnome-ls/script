#!/bin/bash
#Funciones
function backupzip_norm {
	cd /home/jccv/ManageEngine/AppManager14/working/backup
	var10=$(pwd)
	echo "estas en ====> $var10"
	backnormal=$(find -name "backupzip_NORM_*")
	echo "$backnormal" | tee backup_norm.txt
	sed -i 's%./%/%g' "backup_norm.txt"
	a=$(cat backup_norm.txt)
	echo "archivo =======> $backnormal"
	cd /home/jccv/ManageEngine/AppManager14/bin
	./RestorePGSQLDB.sh "$var10$a" | tee backupzip_norm.txt
}

function backupconfigzip {
	cd /home/jccv/ManageEngine/AppManager14/working/backup
	va10=$(pwd)
	echo "estas en ====> $var0"
	backnormal2=$(find -name "backupconfzip_NORM_*")
	echo "$backnormal2" | tee backupcon.txt
	sed -i 's%./%/%g' "backupcon.txt"
	b=$(cat backupcon.txt)
	echo "archivo =======> $backnormal"
	cd /home/jccv/ManageEngine/AppManager14/bin
	./RestoreConfig.sh "$var1$0b" | tee backupzipconfigzip.txt
}

cd /home/jccv/ManageEngine/AppManager14
var=$(pwd)
echo "estas en ====> $var"


if [ -f /home/jccv/ManageEngine/AppManager14/startApplicationsManager.sh ]; then
	echo "Existe startApplicationsManager.sh"
	#nohup sh startApplicationsManager.sh &
	#tail -F nohup.out
	#jobs


	if  grep "Please connect your client to the web server on port: 9090" nohup.out ; then
		echo "instalado..."
		cd /home/jccv/ManageEngine/AppManager14/
		var2=$(pwd)
		echo "estas en ====> $var2"
		cd /home/jccv/backup_prueba/
		var3=$(pwd)
		echo "estas en ====> $var3" #/home/Gnome/backup/
		va=$(ls)
		echo "$va" 
		cp $va /home/jccv/ManageEngine/AppManager14/working/backup
		cp wlclient.jar /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
		cp wljmxclient.jar /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
		cd /home/jccv/
		cd /home/jccv/ManageEngine/AppManager14/working/backup/
		var4=$(pwd)
		echo "estas en ====> $var4" #/home/jccv/ManageEngine/AppManager14/working/backup/
		cd /home/jccv/ManageEngine/AppManager14/ 
		var5=$(pwd)							
		echo "estas en ====> $var5"			
		echo "Bajando aplicación..."
		sleep 5s
		./shutdownApplicationsManager.sh -force
		sleep 5s
		cd /home/jccv/ManageEngine/AppManager14/working/backup/
		var9=$(pwd)
		echo "estas en ====> $var9"
		cd /home/jccv/ManageEngine/AppManager14/bin/
		var10=$(pwd)
		echo "estas en ====> $var10"
		echo "backupzip_norm"
		backupzip_norm
		#cd /home/jccv/ManageEngine/AppManager14/bin/
		telnet 127.0.0.1 15434 | tee telnetbase.txt
		sleep 5s
		if  grep "Connected to 127.0.0.1." telnetbase.txt; then  
			echo "#######################################" 
			echo "Conectado 15434/tcp base de datos"
			backupconfigzip
			#if grep "" backupzipconfigzip.txt; then
			#	echo ""
			var11=$(pwd)
			echo "estas en ====> $var11"
			cd /home/jccv/ManageEngine/AppManager14/working/backup/
			pwd=$
			cd /home/jccv/backup_prueba/
			cd /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
		else
			echo "#########################################"
			echo "		VOLVER A CARGAR.."
			backupzip_norm
			cd /home/jccv/ManageEngine/AppManager14/
			var2=$(pwd)
			echo "estas en ====> $var2"
			cd /home/jccv/backup_prueba/
			var3=$(pwd)
			echo "estas en ====> $var3" #/home/Gnome/backup/
			va=$(ls)
			echo "$va" 
			cp $va /home/jccv/ManageEngine/AppManager14/working/backup
			fi
			if  [ -f wlclient.jar ]; then
				echo "#######################################"
				echo "Ya esta el archivo wlclient.jar"
				echo "#######################################"
				cd /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
				version=$(pwd)
				echo "estas en ====> $version"
				cd /home/jccv/ManageEngine/AppManager14
				version2=$(pwd)
				echo "estas en ====> $version2"
				echo "#######################################"
				echo "LEVANTAR APLICACIÓN"
				sleep 30s
				nohup sh startApplicationsManager.sh &
				tail -F nohup.out

			else 
				cd /home/jccv/backup_prueba/
				cp=$(pwd)
				echo "estas en ====> $cp"
				echo "#######################################"
				echo "copiando archivo wlclient"
				echo "#######################################"
				cp wlclient.jar /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
				cp wljmxclient.jar /home/jccv/ManageEngine/AppManager14/working/classes/weblogic/version12
			fi

	else
		echo "Fallo"
	fi
else 	
	cd /home/jccv/
	rm -rf  ManageEngine
	cd /home/jccv/Escritorio/script-clon/script/SIGI/
	./instalacionMonitor.sh
fi
