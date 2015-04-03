#!/usr/bin/env bash

#
# Fail if errors.
#
set -e

#
# Packs a folder as an ear or war file.
#
ARCHIVENAME=`echo "$1" | sed -r 's|^.*/(.*?)$|\1|g'`
ARCHIVENAME="$ARCHIVENAME.$2"

echo "Creating archive $ARCHIVENAME"

rm -f $ARCHIVENAME
cd $1
zip -r ../$ARCHIVENAME .
cd ..

