cd $INSTALL_DIR
STAGE="Choose Base"
echo ${STAGE}
source setup/base_install_komodo.sh
source setup/base_install_chips.sh
source setup/base_install_verus.sh
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console - ${STAGE}" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
CONSOLE "CONSOLE - go to the console instead of installing a base project" \
KOMODO "KOMODO - featuring the blockchain starter kit & 30+ independent ecosystem projects" \
CHIPS "CHIPS - decentralized peer-to-peer poker" \
VERUS "VERUS - public blockchains as a service (PBaaS)" \
MAINT "Maintenance menu" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	CONSOLE) source setup/console.sh;;
	KOMODO) submenu_install_komodo;;
	CHIPS) submenu_install_chips;;
	VERUS) submenu_install_verus;;
	MAINT) submenu_maint;;
	Exit) echo "Bye"; break;;
esac
done
