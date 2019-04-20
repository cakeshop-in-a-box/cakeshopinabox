source setup/hush3.sh
source setup/bsk1n.sh
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
Choose the TASK" 25 120 14 \
HUSH3 "Get Info - KMDICE getinfo method" \
CHIPS "List Unspent UTXO - KMDICE listunspent" \
VERUS "Get Network Info - KMDICE getpeerinfo" \
BSK_1_HOST "Blockchain Starer Kit - single node seed & mining" \
BSK "Blockchain Starter Kit - (experimental) seed node or mining node" \
NEW_DEV_WALLET "Create a new dev wallet to import on blockchains" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	HUSH3) install_hush3;;
	CHIPS) install_chips;;
	VERUS) install_verus;;
	BSK_1_HOST) bsk1n;;
	BSK) bsk;;
	NEW_DEV_WALLET) setup_devwallet;;
	Back) echo "Bye"; break;;
esac
done
}
