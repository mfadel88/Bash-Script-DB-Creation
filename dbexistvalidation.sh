#!/bin/bash
#dbexistvalidation.sh
while true
do
	echo "((((( ENTER AN EXIST DATABASE AGAIN)))))"
	read existdb
	if [ -d "${existdb}" ];
	then
		cd $existdb
		echo "^^YOU ARE NOW IN $existdb DB^^"
	else
		echo "ATTENTION: > $existdb DB IS NOT EXIST KINDLY SELECT 1 or 2 option in order to forward you to creation or exit mode"
		select db in "create DB" "Exit"
		do
			case $REPLY in
				1) 
					echo "----> Waite just 1 sec you will have been forwarded to DB creation mode <----"
					sleep 1 
					./createdb.sh
					;;

				2)
					echo "----> You select to exit <----"
					exit
					;;

				*)
					echo "--->Unvalid option try again"
			esac
		done
	fi
done
