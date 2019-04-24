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
HUSH3 "Install/Update HUSH3" \
HUSH3CONSOLE "Start/Sync & control HUSH3" \
CHIPS "(development Q2 2019)" \
VERUS "(development Q2 2019)" \
BSK_1_HOST "Blockchain Starer Kit - single node seed & mining" \
BSK "Blockchain Starter Kit - (experimental) seed node or mining node" \
NEW_DEV_WALLET "Create a new dev wallet to import on blockchains" \
REKT0 "Sync & Start PEGS - REKT0" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	HUSH3) install_hush3;;
	HUSH3CONSOLE) submenu_hush3;;
	CHIPS) install_chips;;
	VERUS) install_verus;;
	REKT0) start_pegs_REKT0;;
	BSK_1_HOST) bsk1n;;
	BSK) bsk;;
	NEW_DEV_WALLET) setup_devwallet;;
	Back) echo "Bye"; break;;
esac
done
}
