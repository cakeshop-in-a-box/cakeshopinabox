source setup/hush3.sh
source setup/bsk.sh

function submenu_maint {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ M A I N T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
HUSH3 "Get Info - KMDICE getinfo method" \
CHIPS "List Unspent UTXO - KMDICE listunspent" \
VERUS "Get Network Info - KMDICE getpeerinfo" \
CREATE "Create a new blockchain" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	HUSH3) install_hush3;;
	CHIPS) install_chips;;
	VERUS) install_verus;;
	CREATE) bsk;;
	Back) echo "Bye"; break;;
esac
done
}
