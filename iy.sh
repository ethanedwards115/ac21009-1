#!/bin/sh

# > /dev/null redirects outputs away from screen

##
# make a repository
##

mkrepo()
{

    if ! test -d $1
    then
        mkdir $1
    fi

    if ! test -e ".iy.log"
    then
        cd $1 > /dev/null

        touch ".iy.log"
        echo "$(date) | Repository created" | tee -a .iy.log

        cd .. > /dev/null

    else

        echo "iy: repository \"$1\" already exists."
        return 1
    fi

    return 0
}

##
# add a file to the repo
##
add()
{

    h="Usage: iy add [-c] <filename> <repository>\n-c creates the file and then adds it to the repository"
    m=""
    newfile=""
    for i in $@; do :; done; repo="$i"

    if ! [ -e "$repo/.iy.log" ]
    then

        echo "iy: \"$repo\" is not a repository."

        return 1

    fi

    while getopts ":hc:" opt; do

        #echo "debug"

        case ${opt} in

            "h" )
                echo $h
                return 0
                ;;

            "c" )

                newfile="$OPTARG"

                if ! [ -e $newfile ]
                then

                    touch $newfile

                else
                    echo "iy: file \"$OPTARG\" already exists in repository \"$3\"."

                fi
                ;;

            \? )
                echo "iy: option \"$OPTARG\" not recognised."
                ./iy-help.sh

                return 0
                ;;

            ":" )
                echo "iy: -$OPTARG requires an argument."
                echo "\n$h"
                return 0
                ;;

        esac
    done

    if [ $# -lt 2 ]
    then

        echo "$h"
        return 1

    fi

    if [ $# -eq 2 ]
    then

        newfile="$1"

    fi

    mv "$newfile" "$repo/$newfile"

    if [ -z "$m" ]
    then

        m="$(date) | File \"$newfile\" added to \"$repo\""
        
    fi

    echo "$m" | tee -a "$repo/.iy.log"

    return 0
}

##
# checkout a file from the repo
##
checkout()
{
    h="Usage: iy checkout <file> <repository> [<location>]"
    file="$1"
    repo="$2"
    location="$3"

    if ! [ -e "$repo/.iy.log" ]
    then

        echo "iy: \"$repo\" is not a repository."

    fi

    if ! [ -e "$repo/$file" ]
    then

        echo "iy: file \"$file\" not found in repository \"$repo\"." 
        return 1

    fi

    if [ $# -eq 2 ]
    then

        location=$(pwd)
    
    else 

        if ! [ -d $location ]
        then

            echo "iy: \"$location\" is not a valid location."

        fi

    fi

    mv "$repo/$file" "$location"

    echo "$(date) | File \"$file\" checked out from \"$repo\" to \"$location\"" | tee -a "$repo/.iy.log"

    return 0
}

##
# shows the contents of the repository
##
showrepo()
{
    h="Usage: iy showrepo <repository>"

    if [ $# -gt 1 ]
    then
        echo "iy: showrepo expects 1 argument.\n"
        echo $h

        return 1
    fi

    if ! [ -e "$1/.iy.log" ]
    then
        echo "iy: \"$1\" is not a repository.\n"
        echo $h

        return 1
    fi

    find $1 ! -name ".*"

    return 0
}

##
# finds a file in the repository
##

##
# main program
##

$@