#!/bin/sh

# > /dev/null redirects echo outputs away from screen

##
# initialises history (.iy) file
##
initiy()
{
    if ! test -e ".iy.log"
    then
        touch ".iy.log"
        echo "Repository created: $(date)." | tee -a .iy.log

    else

        echo "iy: repository \"$1\" already exists."

    fi
}

##
# make a repository
##
mkrepo()
{
    if ! test -d $1
    then
        mkdir $1
    fi

    cd $1 > /dev/null 
    initiy $1
    cd .. > /dev/null

    return 0
}

##
# add a file to the repo
##
add()
{

    h="Usage: iy add [-c] <filename> <repository>"

    while getopts ":hc:" opt; do
        case ${opt} in

            "c" )
                if ! test -e $OPTARG
                then
                    touch $OPTARG
                    mv "$OPTARG" "$3/$OPTARG"
                    return 0

                else
                    echo "iy: file \"$OPTARG\" already exists."

                fi
                ;;
            
            "h" )
                echo $h
                return 0
                ;;

            \? )
                echo "iy: option \"$OPTARG\" not recognised."
                ./iy-help.sh

                return 0
                ;;

            ":" )
                echo "iy: -$OPTARG requires an argument.\n" 1>&2
                echo "\n$h"
                return 0
                ;;

        esac
    done

    if [ $# -lt 2 ]
    then

        echo $h

    fi

    if [ $# -eq 2 ]
    then
        mv $1 $2/$1

    fi

    return 0
}

##
# checkout a file from the repo
##


##
# main program
##
$@