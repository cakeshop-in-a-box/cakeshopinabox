cd $INSTALL_DIR
if [ ! -f /root/.devwallet ]; then
  setup_devwallet
fi
source setup/chips.sh
source setup/kmdice.sh
source setup/pirate.sh
source setup/regtest.sh
source setup/maint.sh

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
CHIPS "CHIPS - play decentralized poker" \
MAINT "Maintenance menu" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	REGTEST) submenu_regtest;;
	KMDICE) submenu_kmdice;;
	CHIPS) submenu_chips;;
	PIRATE) submenu_pirate;;
	MAINT) submenu_maint;;
	Exit) echo "Bye"; break;;
esac
done
