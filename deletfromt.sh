#!/bin/bash
#deletfromt.sh
cd $conndb
echo "^===> Enter table name to delet it <===^"
read table_name
    if [ -f $table_name ]
    then
            primk=$(awk 'BEGIN{FS=":"}{if(NR==1)print $1;}' $table_name.md)
            echo "^===>Primary key is... <===^"
            sleep 1
            echo "${primk}"
            sleep 1
            echo "^===>Choose from the date listed below <===^"
            awk 'BEGIN{FS=":"}{print $1;}' $table_name
                while [[ true ]]
                do
                    echo "^===> Enter value to delete row <===^"
                    read  item
                    pkvlues=$(awk -v items="$item" '{if($1==items){ print NR}}' $table_name)
                        if [ -f $pkvlues ];
                        then
                                echo "^===>Not right"
                        else
                                break
                        fi
                done
            #i:to remove from the original files not just show
            sed -i "$pkvlues d" $table_name;
            echo "*=====> Record which begain with $item has been deleted successfuly <===*="
            sleep 1
            echo "*=====> The table view after process <=====* "
            awk 'BEGIN{FS=":"}{print $1;}' $table_name
    else
            echo not exist
fi
