 #!/bin/bash
# Simple script to launch several tools from the command line

# Include functions from other file(s)
source toolsmenu.sh
# ...

# Main body
main_menu
read Action
case $Action in
  1 )

    ;;
  2 )
    checkfiles
    ;;
  3 )
    backu
    ;;

  * )
    echo "That's not an option"
    exit 1
    ;;

  esac
  exit 0
