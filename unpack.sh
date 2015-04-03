#!/usr/bin/env bash

#
# fail on errors
#
set -e

#
# Unpacks a given ear/war file.
#
FOLDERNAME=`echo "$1" | sed -r 's|^(.*/)?(.*)(\..*?)$|\2|g'`
echo "Creating folder $FOLDERNAME in `pwd`"
mkdir $FOLDERNAME
cd $FOLDERNAME
unzip ../$1
cd ..

