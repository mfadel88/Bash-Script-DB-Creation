#!/bin/bash
#menue.sh change dir to project dir
cd $HOME/DBPROJ/
echo "Choose what you need to do"
select number in "Press 1 to create Databases" "press 2 to List Databases" "press 3 to Connect To Databases" "press 4 to Drop Database" "Exit"
do
	case $REPLY in 
		1) 
			echo "---> YOU ARE SELECT DATABASE CREATIO MODE"
			./createdb.sh
			;;

		2)
			echo "---> YOU ARE SELECT DATABASES LIST MODE"
			./list.sh
			;;

                3)
                        echo "---> YOU ARE SELECT DATABASES CONNECT MODE"
			./connectdb.sh
                        ;;
                4)
                        echo "---> YOU ARE SELECT DROP MODE"
			./dropdb.sh
                        ;;
		5)
		        echo "---> YOU ARE SELECT TO EXIT"	
			exit
			;;
                *)
                        echo "Try again"
                        ;;

		esac
	done
ps1="SELECT NUM > "


