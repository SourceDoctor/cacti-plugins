#!/bin/bash

SEARCHARG="${1:-all}"
HOMEDIRROOT="${2:-/home}/"

USERCOUNT=$(ls -1 $HOMEDIRROOT| wc -l)
LIMIT=10


# save and change IFS for \n as Separator
OLDIFS=$IFS
IFS=$'\n'

COUNTER=-1
OUTPUT=""
USERLIST=$(sudo du -cb --max-depth=0 $HOMEDIRROOT*|sort -gr)

for SINGLEUSER in $USERLIST; do
    let "COUNTER++"

    if [ "$COUNTER" -gt "$USERCOUNT" ] ; then
        break
    elif [ "$COUNTER" -gt "$LIMIT" ] ; then
        break
    elif [ "$COUNTER" -eq "0" ] ; then
        #set first line username with "total", because of language differences for total discusage
        USERNAME="total"
    else
        USERNAME="user$COUNTER"
    fi

    DISCUSAGE=$(echo $SINGLEUSER|awk '{print $1}')

    if [ "$SEARCHARG" = "all" ] ; then
        OUTPUT="$USERNAME:$DISCUSAGE $OUTPUT"
    elif [ "$SEARCHARG" = "$USERNAME" ] ; then
        OUTPUT="$DISCUSAGE"
        break
    fi
done

if [ "$OUTPUT" = "" ] ; then
    OUTPUT="0"
fi

# restore IFS
IFS=$OLDIFS

echo -n $OUTPUT

