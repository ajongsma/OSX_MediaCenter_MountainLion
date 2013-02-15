source ../config.sh
if [[ $INST_NEWZNAB_KEY_API == "" ]]; then
    echo "| Main Site Settings, API:"
    echo "| Please add the NewzNAB API key to config.sh"
    echo "-----------------------------------------------------------"
    subl ../config.sh
    open  http://localhost/newznab/admin/site-edit.php
    while ( [[ $INST_NEWZNAB_KEY_API == "" ]] )
    do
        printf 'Waiting for NewzNAB API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
        source ../config.sh
    done
fi