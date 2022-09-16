#!/bin/bash
#createtable.sh

function check_table_exist
{
        if [ -f "$newtable" ];
        then
                return 0;

        else
                return 1;
        fi


}
##########################################################################################

function table_name_regex
{

        if [ -z "${newtable}" ];
    then
                echo "Check the first rule : Name should not be null."
        else
                if [[ $newtable = [0-9]* ]];
        then
                        echo "Check the 5th rule: Name shouldn't start with Number. "
                else
                        if [[ $newtable = *[" "]* ]];
            then
                                echo "Check the 4th rule: Name should not contain a space."
                        else

                                if [[ "$newtable" = *['!'@#\$%^\&*()'-'+'~'=\/]* ]];
                then
                                        echo "Check the 3th rule: Avoid any special characters like >< ? * # '@# \ $ %^ \ & *()."
                                else

                                        if [[ $newtable = ^.* ]];
                    then
                                                echo "Check the 2nd rule: Name should not start with . or .. "
                                        else

                                                echo "$newtable table name is validate"

                                        fi
                                fi
                        fi
                fi
        fi




}
##########################################################################################
function columns_number 
{
	#numbers
	if [[ $columnsnumber = [1-9] ]]; 
    then
		return 0;
	fi
	if [[ $columnsnumber = [1-9][0-9]  ]]; 
    then
		return 0;
	else				
		echo  "cant define number of columns"
		return 1;
	fi
}
##########################################################################################
function read_columns_numbers 
{	
	echo "=^^* Plz, enter columns_number =^^*";
	read columnsnumber;

	while [[ true ]]
	do
		if columns_number ; 
                then
	
			break;
		else 
			echo "*^^= Use another columns_number =^^*"		
	  		read columnsnumber;
	        fi

	done
}
##########################################################################################
function checkexist_column_name 
{
	Exist=$(awk -v colName="$column_name" -F: 'BEGIN{Exist=0} {if($1==colName) {Exist=1}} END{print Exist}' $newtable.md);
	if [ $Exist -eq 1 ]; then
		return 1;
	else 
		return 0;
        fi
}


##########################################################################################
function validate_column_name 
{
        if [ -z "${newcolumn}" ];
    then
                echo "Check the first rule : Name should not be null."
        else
                if [[ $newcolumn = [0-9]* ]];
        then
                        echo "Check the 5th rule: Name shouldn't start with Number. "
                else
                        if [[ $newcolumn = *[" "]* ]];
            then
                                echo "Check the 4th rule: Name should not contain a space."
                        else

                                if [[ "$newcolumn" = *['!'@#\$%^\&*()'-'+'~'=\/]* ]];
                then
                                        echo "Check the 3th rule: Avoid any special characters like >< ? * # '@# \ $ %^ \ & *()."
                                else

                                        if [[ $newcolumn = ^.* ]];
                    then
                                                echo "Check the 2nd rule: Name should not start with . or .. "
                                        else

                                                echo "$newcolumn is validate name"

                                        fi
                                fi
                        fi
                fi
        fi
}

##########################################################################################
function read_columns_names_and_types {

	for (( i=1; i<=$columnsnumber; i++ ))
	do
		if (( $i==1 ));
	       	then
			echo "*==== Enter the primary_key After check the below rules ====*";			
			while [[ true ]]
			do
			       echo "===> column name rules <=== :
                                                      1) Name should not be null.
                                                      2) Name should not start with . or .. or numbers.
                                                      3) Avoid any special characters like >< ? * # '@#\$%^\&*().
                                                      4) Name should not contain a space.
                                                      5) Name shouldn't start with Number. " /t
                               echo "***^Enter your valid new column name:"
	
				read newcolumn;
				if checkexist_column_name; 
                                then
					if validate_column_name ;
                                        then
						break;
					else 					
						echo "*==== Use another PK name ====*"	 
					fi
				else
					echo  "error, column_name is exist"
					echo "*==== Use another PK name ====*"
				fi
				
			done
			echo "*==== Choose primary_key_type ====*"
			validate_column_type $i;
			echo $newcolumn:$type >> $newtable.md
         		else
			echo "*==== Enter column_name ====*";
			while [[ true ]]
			do 
				read column_name;
				if checkexist_column_name;
			       	then
					if validate_column_name ;
					then
						#if the column_name doesn't exist and valid then break
						break;
					else 					
						echo  "Conflict, can't use this column name}"
						echo "*==== Use another column name ====*"	 
					fi
				else
					echo -e "Conflict, column_name is exist"
					echo "*==== Use another column name ====*"
				fi
				
			done		
			echo "*==== Choose column_type ====*"
			validate_column_type $i;
			echo $column_name:$type >> $newtable.md 
		fi   	
	done
}
##########################################################################################
function validate_column_type {
	while [[ true ]]
	do
		select type in 'Integer' 'String' 'AlphaNumeric'
		do
			case $REPLY in 
				1) break 2 ;;
				2) break 2 ;;
				3) break 2 ;; 
				*) echo  "Only support String, Integer and AlphaNumeric"
				echo "Use one of them..."
				break ;;
			esac
		done		
	done
}

##########################################################################################
function create_table
{
	sleep 1
        echo "^====^ CREATE TABLE ^====^"
	echo "===> Table name rules <==== :
                        1) Name should not be null.
                        2) Name should not start with . or .. or numbers.
                        3) Avoid any special characters like >< ? * # '@#\$%^\&*().
                        4) Name should not contain a space.
                        5) Name shouldn't start with Number. " /t
        sleep 1
        echo "====> Kindly enter table Name <===="
        read newtable
        while true
        do
                if check_table_exist ;
                then
                        echo "**** This table is already exist ****"
                        break;
                fi
                if table_name_regex; 
                then
                    #if the table is not existed before and have a vaild name 
		    cd $conndb
                    touch $newtable;
                    touch $newtable.md;				
                    #insert Table metaData
                    read_columns_numbers;
                    read_columns_names_and_types ;
                    echo  "*==== Table created successfuly ====*"	
                    break;
		        else 
                    echo "*==== Use another name ====*"
                    read newtable;
                fi
                

        done
}
##########################################################################################
create_table
while true
do
        echo "*==== Do you want to create another table! ===="
        select one in "YES" "NO"
        do
                case $REPLY in
                        1)
                                create_table
                                break
                                ;;
                        2)
                                break 2
				exit
                                ;;
                        *)
                                echo "---> Nothing to do now <---"
                                sleep 1
                                echo "** Exit **"
                                break
                                ;;
                esac
        done

done
