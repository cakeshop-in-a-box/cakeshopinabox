function submenu_beer {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ B E E R - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
BEER_GETINFO "Get Info - BEER getinfo method" \
BEER_LISTUNSPENT "List Unspent UTXO - BEER listunspent" \
BEER_GETPEERINFO "Get Network Info - BEER getpeerinfo" \
BEER_GETMININGINFO "Get Mining Info - BEER getmininginfo" \
BEER_DELETE "Experimental - Delete blockchain data" \
BEER_START "Start BEER" \
BEER_STOP "Stop BEER" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	BEER_DELETE) delete_blockchain_data_beer;;
	BEER_START) start_beer;;
	BEER_STOP) stop_beer;;
	BEER_GETINFO) getinfo_beer;;
	BEER_GENERATE) generate_beer;;
	BEER_LISTUNSPENT) listunspent_beer;;
	BEER_GETPEERINFO) getpeerinfo_beer;;
	BEER_GETMININGINFO) getmininginfo_beer;;
	Back) echo "Bye"; break;;
esac
done
}
