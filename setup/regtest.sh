function submenu_regtest {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Komodo Console" \
--title "[ K O M O D O - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
REGTEST_START "Give me devmode - start single user dev chain" \
REGTEST_STOP "Stop devmode - stops single user dev chain" \
REGTEST_GETINFO "Get Info - single user dev chain getinfo method" \
REGTEST_GENERATE "Generate - single user dev chain generate blocks" \
REGTEST_LISTUNSPENT "List Unspent UTXO - single user dev chain listunspent" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	REGTEST_START) start_regtest;;
	REGTEST_STOP) stop_regtest;;
	REGTEST_GETINFO) getinfo_regtest;;
	REGTEST_GENERATE) generate_regtest;;
	REGTEST_LISTUNSPENT) listunspent_regtest;;
	Exit) echo "Bye"; break;;
esac
done
}
