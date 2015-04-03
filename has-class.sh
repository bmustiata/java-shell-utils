#!/usr/bin/env bash

#
# jar-has-class.sh
#
# Finds what JAR has the given class.
#

CLASS_NAME=$1
shift

SHOW_MATCHES="false"
MATCH_PACKAGES="false"

#
# show_usage
# $1 - exit code
#
function show_usage() {
    echo "Usage: $0 classname [-m] [-p]"
    exit $1
}

while (( "$#" )); do
    if [[ "$1" == "-m" ]]; then
        SHOW_MATCHES="true"
    fi # [[ "$1" == "-m" ]]

    if [[ "$1" == "-p" ]]; then
        MATCH_PACKAGES="true"
    fi # [[ "$1" == "-p" ]]

    if [[ "$1" == "-v" ]]; then
        VERBOSE=true
    fi # [[ "$1" == "-v" ]]

    if [[ "$1" == "-h" ]]; then
        show_usage 0
    fi # [[ "$1" == "-h" ]]

    shift
done

#
# Some sanity checking
#
if [[ "$CLASS_NAME" == "" ]]; then
    show_usage 1
fi # [[ "$CLASS_NAME" == "" ]]

#
# Parameter parsing:
# Find the name of the class in the JAR file
#
if [[ $CLASS_NAME =~ '.' ]]; then
    if [[ ! $CLASS_NAME =~ '/' ]]; then
        if [[ "$MATCH_PACKAGES" == "true" ]]; then
            CLASS_NAME="`echo $CLASS_NAME | sed s/\\\./\\\//g`"
        else # not [[ $MATCH_PACKAGES ]]
            CLASS_NAME="`echo $CLASS_NAME | sed s/\\\./\\\//g`.class"
        fi   # else [[ $MATCH_PACKAGES ]]
    fi # if [[ ! $CLASS_NAME =~ '/' ]]
fi # [[ $CLASS_NAME =~ '.' ]]

echo "Searching for $CLASS_NAME in jars"

#
# Search for the file
#
for f in `find . -name \*.jar -type f`; do
    if [[ $VERBOSE ]]; then
        echo -n "Searching $f .. "
    fi # [[ $VERBOSE ]]

    HAS_CLASS=`unzip -qq -l $f | tr -s " " | cut -f5 -d\  | grep $CLASS_NAME`

    if [[ $VERBOSE ]]; then
        echo "done"
    fi # [[ $VERBOSE ]]

    if [[ "" != "$HAS_CLASS" ]]; then
        if [[ "$SHOW_MATCHES" == "true" ]]; then
            echo "============================================================================="
        fi

        echo $f

        if [[ "$SHOW_MATCHES" == "true" ]]; then
            echo "-----------------------------------------------------------------------------"
            for CLASS in $HAS_CLASS; do
                echo $CLASS
            done
            echo "============================================================================="
        fi # [[ $SHOW_MATCHES == "true" ]]
    fi # [[ "" -ne "$HAS_CLASS" ]]
done

