#!/bin/sh

# > /dev/null redirects echo outputs away from screen

##
# initialises history (.iy) file
##
initiy()
{
    touch ".iy.log"
    echo "Repository created: $(date)" > .iy.log
}

##
# make a repository
##
mkrepo()
{
    if ! ls -d $1
    then
        mkdir $1
    fi

    cd $1
    initiy
    cd ..

    return 0
}

##
# 
##


##
# main program
##
$@