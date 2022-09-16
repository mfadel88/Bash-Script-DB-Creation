#!/bin/bash
#createdb1.sh fpr create new DB
while true
do
	sleep 2
	echo "^^^^^^ YOU ARE NOW IN DATA BASE CREATIO MODE^^^^^^"
	sleep 2
	echo "Kindly follow the rules that will appear below when you going to write your new DB name in order to avoide any error"
        sleep 2
        echo "Database name rules :
                        1) Name should not be null.
                        2) Name should not start with . or .. or numbers.
                        4) Avoid any special characters like >< ? * # '@#\$%^\&*().
                        6) Name should not contain a space.
                        7) Name shouldn't start with Number. " /t
echo "#Enter your valid new DB name:"
read newdb
	cd $HOME/DBPROJ
	if [ -z "${newdb}" ];
    then
		echo "Check the first rule : Name should not be null."
	else
		if [[ $newdb = [0-9]* ]];
        then
			echo "Check the 7th rule: Name shouldn't start with Number. "
		else
			if [[ $newdb = *[" "]* ]];
            then
				echo "Check the 6th rule: Name should not contain a space."
			else
				
				if [[ "$newdb" = *['!'@#\$%^\&*()'-'+'~'=\.\/]* ]];
                then
 					echo "Check the 4th rule: Avoid any special characters like >< ? * # '@# \ $ %^ \ & *()."
				else
					
					if [[ $newdb = ^.* ]]; 
                    then
 						echo "Check the 2nd rule: Name should not start with . or .. "
					else
						if [ -d "${newdb}" ];
                        then
							echo  "This Database Already Exist"
						else
							
 							mkdir $newdb
							echo "^^^**Congrtulations your new DB has been created Successfuly**^^^"
							break
									
						fi
					fi
				fi
			fi
		fi
	fi
done



