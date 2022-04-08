#!/bin/bash
# Simple script to launch several tools from the command line

# Include functions from other file(s)
source toolsmenu.sh
# ...

# Main body
Action=$(main_menu)
$p=$1
case $p in
    a )
    echo "s2314e1dewfwergfq"
    #launch antivirus tools
    # ...
    ;;

    2 )
    #Analyse a directory
    #Check permissions
    # ...
    ;;
    3 )
    #Make a back up with tar
    # ...
    ;;

  * )
    echo "sorry, wong option"
    exit 1
    ;;

  esac

  exit 0
