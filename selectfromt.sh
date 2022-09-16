#!/bin/bash
cd $conndb
echo "**==>Enter table name plz<==**"
read table
    if [ -f $table ]
    then
            echo "**==>wait while display content of table<==**"
            sleep 2
            echo "**==>metadata of table<==**"
            awk 'BEGIN {FS=":"} {if(NR>0) printf $1"<"$2">\t\t"} END{printf "\n"}' $table
            echo "**==>enter value to select <==**"
            read patt
    fi

    if [ -z $patt ]
    then
            echo "**==>dosnt match<==**"
    else
    sed -n "/$patt/p" $table
    fi
