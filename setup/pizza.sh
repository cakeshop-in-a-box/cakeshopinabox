function submenu_pizza {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ P I Z Z A - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
PIZZA_GETINFO "Get Info - PIZZA getinfo method" \
PIZZA_LISTUNSPENT "List Unspent UTXO - PIZZA listunspent" \
PIZZA_GETPEERINFO "Get Network Info - PIZZA getpeerinfo" \
PIZZA_GETMININGINFO "Get Mining Info - PIZZA getmininginfo" \
PIZZA_DELETE "Experimental - Delete blockchain data" \
PIZZA_START "Start PIZZA" \
PIZZA_STOP "Stop PIZZA" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	PIZZA_DELETE) delete_blockchain_data_pizza;;
	PIZZA_START) start_pizza;;
	PIZZA_STOP) stop_pizza;;
	PIZZA_GETINFO) getinfo_pizza;;
	PIZZA_GENERATE) generate_pizza;;
	PIZZA_LISTUNSPENT) listunspent_pizza;;
	PIZZA_GETPEERINFO) getpeerinfo_pizza;;
	PIZZA_GETMININGINFO) getmininginfo_pizza;;
	Back) echo "Bye"; break;;
esac
done
}
