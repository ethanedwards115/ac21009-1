#!/usr/bin/bash

echo "Usage:"
   echo "   bash iy.sh <command> [options] [args] - standard format for commands."
   echo "   mkrepo <rep_name> - create a new repository."
   echo "   add [-c] <file> <repository> - add a new file to the repository. -c creates the file if it doesn\`t already exist."
   echo "   checkout <file> <repository> [location] - checkout a file from the repository (location - directory where the checked-out file should go)."
   echo "   showrepo <repository> - display the contents of the repository."
   echo "   help - show this help screen."
   echo "   backup <repository> - manually backup a repository. This should be done automatically when files are added, but you must do this yourself after any edits."
   echo "   rollback <repository> - restore a repository to its most recently backed-up state."
