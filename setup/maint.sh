source setup/hush3.sh

function submenu_maint {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Komodo Console" \
--title "[ M A I N T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
MAINT_HUSH "Get Info - KMDICE getinfo method" \
MAINT_CHIPS "List Unspent UTXO - KMDICE listunspent" \
MAINT_VERUS "Get Network Info - KMDICE getpeerinfo" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	MAINT_HUSH) install_hush3;;
	MAINT_CHIPS) install_chips;;
	MAINT_VERUS) install_verus;;
	Back) echo "Bye"; break;;
esac
done
}
