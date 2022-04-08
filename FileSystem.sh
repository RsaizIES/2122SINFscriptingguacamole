#!/bin/bash
#parse a stringh , get onde by one all characters
if [ -z "$1" ]
    then echo "the parameter its empty"
    echo "Try to put a valid Directory"
    echo " '.' /directory "
    exit 1
    fi
Dir=$1
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
