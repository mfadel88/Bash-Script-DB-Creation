#!/bin/bash
#connlist.sh to connect DBs
echo "Now you are connected"
select action in "create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "EXIT"
do
	case $REPLY in
	        1)
                        echo "---> YOU ARE SELECT CREATION TABLE MODE"

			./createtable.sh
			;;

                2)
                        echo "---> YOU ARE SELECT LIST TABLE MODE"
			./tableslist.sh
                        ;;

                3)
                        echo "---> YOU ARE SELECT DROP TABLE MODE"
                        ./tabledrop.sh
			;;
                4)
                        echo "---> YOU ARE SELECT INSERT TABLE MODE"
                        ./inserttable.sh 
                        ;;
		5)
   			echo "---> YOU ARE SELECT SELECT FROM TABLE MODE"
			./selectfromt.sh
                        ;;
		6)
	                echo "---> YOU ARE SELECT DELETE FROM TABLE MODE"
                        ./deletfromt.sh
			;;

		7)
                        echo "---> YOU ARE SELECT UPDATE FROM TABLE MODE"
                        ./updateintable.sh
			;;

		8)
                        echo "---> YOU ARE SELECT TO EXIT"
			exit 0
                        ;;

                *)
                        echo "Try again"
                        ;;

                esac
        done
	       
