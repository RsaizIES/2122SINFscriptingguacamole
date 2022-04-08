 #!/bin/bash
 ###
 # Script for do backup a specific directory
 # To run the script we need 2 parameters - First one is where te log file
 # eill be and the second is what directory will be backed up.
 ###

 #Sanity check
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error in one parameter."
    echo "Reminder that all requiered files will be copied to /home/\$USER/work/work.backup."
    echo "USAGE: ./Scriptname.sh LOGFILE  DIRECTORY-TO-BACKUP"
    exit 1;
fi

MyLog=$1
Backup_from=$2

function ctrlc {
    rm -rf /home/$USER/work/work_backup
    rm -f $MYLOG
    echo "Ctrl + C"
    exit 1;
}

trap ctrlc SIGINT ##Trows ctrlc Function

    echo "Timestamp before work is done $(date + %D +%T")" >> $MyLog
    echo "Creating Backup directory" >> $MyLog
    if ! (mkdir /home/$USER/work/work_backup 2> /dev/null)
    then
        echo "The directory alredy exist." >> $MyLog
    fi
    echo "Copying Files" >> $MyLog
    cp -v $Backup_from/* /home/$USER/work_backup/ >> $MyLog
    echo "Copying files Sucsefully" >> $MyLog
    echo "Timestamp after work done $(date + %D %T")" >> $MyLog
