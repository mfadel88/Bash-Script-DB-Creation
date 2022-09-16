#!/bin/bash
#updateintable.sh
cd $conndb
stringReg="^[a-zA-Z]+[a-zA-Z]*$"
intReg="^[0-9]+[0-9]*$"
alphNumReg="^[a-zA-Z0-9_]*$"


function check_exist 
{
	if [ -f "$table_name" ]; 
        then
		return 0;
	else
		return 1;
  	fi
}

function check_repeated_pk 
{
	isexist=1
	for field in $(cut -f1 -d: "$table_name") 
	do
		if [[ $field == "$1" ]]
		then
			isexist=0
			break
		fi
	done
	return $isexist
}

function cheak_vaild_data 
{

    if [ $1 == "Integer" ] 
    then 
    
        if [[ $2 =~ $intReg ]] 
        then  
        return 1
        else 
        return 0
        fi
    elif [ $1 == "String" ]
    then
        if [[ $2 =~ $stringReg ]]
        then
        return 1
        else
        return 0
        fi
    elif [ $1 == "AlphaNumeric" ]
    then
        if [[ $2 =~ $alphNumReg ]]
        then
        return 1
        else
        return 0
        fi
    
    fi 
}

echo "*==== Enter the table name ====*"
read  table_name
if check_exist; 
then
	pk=$(awk 'BEGIN{FS=":"}{if(NR==1)print $1;}' $table_name.md)	
	echo "Your PK is : ${pk}"
	while [[ true ]]
	do
		echo  "Enter PK Value To Search"
		read item
		pkitem=$(awk -v items="$item" '{if($1==items){ print NR}}' $table_name )
		if [ -f $pkitem ];
                then 
			echo -e "*==== Your PK Value Not Right ====*"
		else
			break
		fi
	done
	rn=$(awk -v items="$item" '{if($1==items){ print NR}}' $table_name )
	echo  "*==== Enter Col Name That You Want To Update ====*"
	read colname
	cn=$(awk -F: '{if($1=="'$colname'"){print NR}}' $table_name.md)
	
	if [ -f $cn ] ;
        then 
		echo "*==== Your Col Name Not Right ====*"
		echo "Press Enter to Continue..."
		read
		break 2;		
	else
		while [[ true ]]
		do		
			echo  "Enter New Value To Update"
			read  newdata
			if [ -z "$newdata" ];
                        then
				echo "*==== ${newdata} can't be NULL ====*"
			else
				if [[ $colname == $pk ]];
                                then
					check_repeated_pk $newdata
    						if [[ $? == 0 ]];
                                                then
        						echo -e "This Is Repeated PK"
						else
							columnsTyps=($(awk -v colNumber="$cn" 'BEGIN{FS=":"}{if(NR==colNumber)print $2;}' $table_name.md))
							cheak_vaild_data $columnsTyps $newdata;
    							if [[ $? == 0 ]];
                                                        then
    								echo -e "Column Type Not Right"
    							else
								awk -v rowNumber="$rn" -v colNumber="$cn" -v newData="$newdata" '{if(NR == rowNumber){$colNumber = newData};print $0;}' $table_name >> $table_name.new;
								mv $table_name.new $table_name
								echo "Table Updated "
								echo "Press Enter to Continue..."
								read
								break 2;
							fi
    						fi
				else
				columnsTyps=($(awk -v colNumber="$cn" 'BEGIN{FS=":"}{if(NR==colNumber)print $2;}' $table_name.md))
				cheak_vaild_data $columnsTyps $newdata;
    				if [[ $? == 0 ]];
                                then
    					echo "Column Type Not Right"
    				else
					awk -v rowNumber="$rn" -v colNumber="$cn" -v newData="$newdata" '{if(NR == rowNumber){$colNumber = newData};print $0;}' $table_name >> $table_name.new;
					mv $table_name.new $table_name
					echo "Table Updated "
					echo "Press Enter to Continue..."
					read
					break 2;
				fi
			fi		
			fi
		done
	fi	
else
	echo  "*==== This Table Isn't Exist! ====*"
	echo "For help use DISPLAY TABLES option To Know Your Tables And Come Again"
	echo "press ENTER to back..."	
	read
fi
