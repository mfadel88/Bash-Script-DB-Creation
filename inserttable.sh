#!/bin/bash
#inserttable.sh to insert data through tables
stringReg="^[a-zA-Z]+[a-zA-Z]*$"
intReg="^[0-9]+[0-9]*$"
alphNumReg="^[a-zA-Z0-9_]*$"

############################

function check_existance
{
        if [ -f "$table_name" ];
        then
                return 0;
        else
                return 1;
        fi

}

#####################################
function read_meta_data
{
        columnsNumber=$( cat $table_name.md | wc -l )
        columnsName=($(awk 'BEGIN{FS=":"}{if(NR>0)print $1;}' $table_name.md))
        columnsTyps=($(awk 'BEGIN{FS=":"}{if(NR>0)print $2;}' $table_name.md))
}
#######################################

function check_repeated_pk {
        isexist=1
        for field in $(cut -f1 -d: "$table_name");
        do
                if [[ $field = "$1" ]];
                then
                        isexist=0
                        break
                fi
        done
        return $isexist
}
############################################
function cheak_vaild_data {
        if [ -z "$data" ];
        then
                echo  "*==== ${columnsName[i]} can't be NULL ====*"
                return 0;
        else
                case ${columnsTyps[$1]} in
                Integer)
                                if [[ $data =~ $intReg ]];
                                then
                                        return 1;
                                else
                                        echo  "*== ${columnsName[i]} only support Interger ==*"
                                        return 0;
                                fi
                                break ;;
                 String)
                                if [[ $data =~ $stringReg ]];
                                then
                                        return 1;
                                else
                                        echo  "*== ${columnsName[i]} only support String ==*"
                                        return 0;
                                fi
                                break ;;
           AlphaNumeric)
                                if [[ $data =~ $alphNumReg ]];
                                then
                                        return 1;
                                else
                                        echo  "*== ${columnsName[i]} only support AlphaNumeric ==*"
                                        return 0;
                                fi
                                break ;;
                esac
        fi
}
##################################################################################3
function read_record {
        for (( i=0; i<$columnsNumber; i++ ))
        do
                if (( $i==0 )); then
                        echo  "*==== ${columnsName[i]} using dataType:${columnsTyps[i]} ====*";
                        while [[ true ]]
                        do
				#-r: Disable backslashes to escape characters.
                                read -r data;
                                if check_repeated_pk $data; then
                                        echo  "*==== Sorry, this PK is used before ====*"
                                        echo "*==== Use another PK ====*"
                                else
                                        if cheak_vaild_data $i; then
                                                echo "*==== Enter data again ====*"
                                        else
                                                #insert here
                                                record[$i]=$data
                                                break ;
                                        fi
                                fi
                        done
                else
                        echo  "*==== ${columnsName[i]} using dataType:${columnsTyps[i]} ====*";
                        while [[ true ]]
                        do
                                read -r data;
                                if cheak_vaild_data $i; then
                                        echo "*==== Enter data again ====*"
                                else
                                        #insert here
                                        record[$i]=$data
                                        break ;
                                fi
                        done
                fi
        done
        echo ${record[*]} >> $table_name
}
############################
cd $conndb
pwd
echo "*==== Enter Table Name ====*"
read table_name
if check_existance; then
        read_meta_data
        echo "*==== Enter the record  ====*"
        read_record;
        echo  "*==== Record inserted successfully ====*"
        while [[ true ]]
        do
                echo  "*==== Do you want insert another record! ====*"
                select type in 'Yes' 'No'
                do
                        case $REPLY in
                                1) read_record;
                                        sleep 1
                                        echo -e "*==== Record inserted successfully ====*"
                                        break
                                        ;;
                                2)
                                        break 2
                                        ;;
                                *)
                                        echo "*==== Exit ====*";
                                        sleep 1
                                        break 2
                                        ;;
                        esac
                done
        done
else
        echo -"*==== This table is not exist! ====*"
        echo "For help use DISPLAY TABLES option To Know Your Tables And Come Again"
        echo "press ENTER to back..."
        read
fi
