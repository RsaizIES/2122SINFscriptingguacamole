#!/bin/bash
#

    echo 'Do you want to execute de antivirus y or n?'

    read respuesta
    
    if  [ $respuesta = 'y' ]
        then
            sudo clamtk
    fi 
     echo 'Do you want to install one antivirus y or n?'
    read respuesta2
    
    if [ $respuesta2 = 'y' ]
            then
	sudo apt install clamtk	
     fi
exit 0
