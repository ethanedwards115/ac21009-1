#!/bin/sh

# > /dev/null redirects echo outputs away from screen

##
# initialises history (.iy) file
##
initiy()
{
    touch .iy
    echo "Repository created: $(date)" > .iy
}

##
# make a repository
##
mkrepo()
{

    mkdir $1

    # TODO Make history file

    initiy

    return 0
}

##
# 
##


##
# main program
##
$1 > /dev/null