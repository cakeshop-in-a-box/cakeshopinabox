function submenu_pirate {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ P I R A T E - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
PIRATE_GETINFO "Get Info - PIRATE getinfo method" \
PIRATE_LISTUNSPENT "List Unspent UTXO - PIRATE listunspent" \
PIRATE_GETPEERINFO "Get Network Info - PIRATE getpeerinfo" \
PIRATE_GETMININGINFO "Get Mining Info - PIRATE getmininginfo" \
PIRATE_DELETE "Experimental - Delete blockchain data" \
PIRATE_START "Start PIRATE" \
PIRATE_STOP "Stop PIRATE" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	PIRATE_DELETE) delete_blockchain_data_pirate;;
	PIRATE_START) start_pirate;;
	PIRATE_STOP) stop_pirate;;
	PIRATE_GETINFO) getinfo_pirate;;
	PIRATE_GENERATE) generate_pirate;;
	PIRATE_LISTUNSPENT) listunspent_pirate;;
	PIRATE_GETPEERINFO) getpeerinfo_pirate;;
	PIRATE_GETMININGINFO) getmininginfo_pirate;;
	Exit) echo "Bye"; break;;
esac
done
}
