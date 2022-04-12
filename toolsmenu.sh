 # File that contains functions for menues and browsing

main_menu () {
  echo "Please, choose an option:" >&2
  echo "1 .- Virus scan options" >&2
  echo "2 .- Analyse directories" >&2
  echo "3 .- Realise a back up" >&2
}
backu() {
    ###
    # Script for do backup a specific directory
    # To run the script we need 2 parameters - First one the source path
    # and the second one the destination path.
    ###
    echo "What do you want copy"
    read C
    echo "Where do you want past it (With ""/"" at the end)"
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
}

checkfiles (){

    echo "Write the parameter"
    read P
    if [ -z "$P" ]
        then echo "the parameter its empty"
        echo "Try to put a valid Directory"
        echo " '.' /directory "
        exit 1
        fi
    Dir=$P
    ls $Dir -1 > buffer.tmp
    while read Element
    do
        #check
        if [ -d "$Dir/$Element" ]; then
            echo "$Element is a directory"
                echo  "$( ls -lh $Dir/$Element )"
            elif [ -f "$Dir/$Element" ] || [ -r "$Dir/$Element" ] && R="Can Read" || R="Can't Read" [ -w "$Dir/$Element" ] && W="Can Write" || W="Can't Write" [ -x "$Dir/$Element" ] && X="Can execute" || X="Can't execute"; then
                echo "$Element is a file // $R,$W,$X"
                echo  "$( ls -lh $Dir/$Element )"
                        else
                            echo "I don't Know whats $Element"
        fi
    done < buffer.tmp

    rm buffer.tmp
    exit 0
}
