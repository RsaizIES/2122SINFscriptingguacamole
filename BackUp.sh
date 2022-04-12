 #!/bin/bash
 ###
 # Script for do backup a specific directory
 # To run the script we need 2 parameters - First one the source path
 # and the second one the destination path.
 ###
echo "Copi"
read C
echo "Where"
read P
 #Sanity check
if [ -z "$C" ] || [ -z "$P" ]; then
    echo "Error in one parameter."
    echo "Reminder that all requiered files will be copied to /home/$USER/$P"
    echo "Usage: $0 /path/to/source /path/destination/"

    exit 1;
fi

#Get the source path and make a time stamp , then get the destination path and put the info of the source
input=$C
backupdate=$(date +"%d%m%Y")
foldername=$(basename "$C")
inputpath=$(dirname "$C")
outpath="${P}"
output="${P}${foldername}_${backupdate}"

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
