 #!/bin/bash
 ###
 # Script for do backup a specific directory
 # To run the script we need 2 parameters - First one the source path
 # and the second one the destination path.
 ###

 #Sanity check
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error in one parameter."
    echo "Reminder that all requiered files will be copied to /home/$USER/$2"
    echo "Usage: $0 /path/to/source /path/destination/"

    exit 1;
fi

#Get the source path and make a time stamp , then get the destination path and put the info of the source
input=$1
backupdate=$(date +"%d%m%Y")
foldername=$(basename "$1")
inputpath=$(dirname "$1")
outpath="${2}"
output="${2}${foldername}_${backupdate}"

function ctrlc {
	rm -rf $inputpath
	rm -f $output
	echo "Function Ctrl+C"
	exit 1
}

trap ctrlc SIGINT

## x while increace if you run the script whit the same directories and change the name
case ${foldername} in
*.tar.bz2)
[ "${inputpath}" = "" ] && inputpath="."i
bzip2 -dck "${inputpath}"/"${foldername}" | tar -C "${outpath}" -x
;;

*)
counter=0
while [ -f "${output}.${counter}.tar.bz2" ]
do
counter=$(expr $counter + 1)
done

output="${output}.${counter}"

# run tar and bzip2 command to make backup
tar -C "${inputpath}" -c "$foldername"|bzip2 -cz >"${output}.tar.bz2"
chmod -x "${output}.tar.bz2"
;;
esac
