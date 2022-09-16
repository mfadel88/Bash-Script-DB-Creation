#!/bin/bash
#connectdb.sh to connect any DB
echo "#Enter Database name which you need to connect:"
read conndb
export conndb
while true
do
	if [ -z "${conndb}" ];
	then
		echo "Nothing has been entered to connect"
		break
		elif [ -d "${conndb}" ];
		then
			echo "connecting to $conndb ..."
			sleep 2
			./connlist.sh
			break
		else 
		        echo "Database which you entered is not exist thanks"	
	fi
done

