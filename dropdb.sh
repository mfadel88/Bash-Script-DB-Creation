#!/bin/bash
#dropdb.sh to remove any DB from my list
echo "#Enter Database name which you need to drop:"
read dropdb
while true
do
	if [ -z "${dropdb}" ];
	then
		echo "Nothing has been entered to delete"
	elif  [ -d "${dropdb}" ];
	then
		rm -r $dropdb
                echo " Congratulations target DB "$dropdb" deleted successfully :)"
	break
else
	echo "Database which you enterd is not exist so kindly try again"
	break
	fi
done
