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
        echo "Repository created: $(date)" > .iy.log

    else

        echo "Repository \"$1\" already exists"

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
    cd .. >/dev/null

    return 0
}

##
# 
##


##
# main program
##
$@