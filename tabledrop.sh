#!/bin/bash
#tabledrop.sh to drop tables from DB
cd $conndb
echo "*====>Enter the table name which you want to drop <====*"
read tablename
	if [ -f "$tablename" ];
	then
		echo "*====>Are You Sure to Delete $tablename Table ====*"
		select confirm in "Confirm" "Dismiss"
		do
			case $REPLY in
				1) echo  "*==== Deleting $tablename ====*"
					rm -r $tablename
					sleep 1
					rm -r $tablename.md
					sleep 1
					echo  "*==== $tablename Table deleted successfuly====*"
                                        echo "press ENTER to back..."
                                        read
                                        break
                                        ;;

                                2)  

                                        echo "*===>You are dismissed drop action <===*"
                                        break
                                        ;;

                                *)
				       	echo "*==== Exit ====*";
                                        echo "press ENTER to back..."
                                        read
                                        break
                                        ;;
			esac
		done
	fi
