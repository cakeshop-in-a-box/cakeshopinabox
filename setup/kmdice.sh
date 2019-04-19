function submenu_kmdice {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ K M D I C E - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
KMDICE_GETINFO "Get Info - KMDICE getinfo method" \
KMDICE_LISTUNSPENT "List Unspent UTXO - KMDICE listunspent" \
KMDICE_GETPEERINFO "Get Network Info - KMDICE getpeerinfo" \
KMDICE_GETMININGINFO "Get Mining Info - KMDICE getmininginfo" \
KMDICE_DELETE "Experimental - Delete blockchain data" \
KMDICE_START "Start KMDICE" \
KMDICE_STOP "Stop KMDICE" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KMDICE_DELETE) delete_blockchain_data_kmdice;;
	KMDICE_START) start_kmdice;;
	KMDICE_STOP) stop_kmdice;;
	KMDICE_GETINFO) getinfo_kmdice;;
	KMDICE_GENERATE) generate_kmdice;;
	KMDICE_LISTUNSPENT) listunspent_kmdice;;
	KMDICE_GETPEERINFO) getpeerinfo_kmdice;;
	KMDICE_GETMININGINFO) getmininginfo_kmdice;;
	Back) echo "Bye"; break;;
esac
done
}
