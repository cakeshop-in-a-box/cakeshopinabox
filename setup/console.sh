cd $INSTALL_DIR
source setup/regtest.sh
source setup/kmdice.sh

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Komodo Console" \
--title "[ K O M O D O - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
REGTEST "Give me devmode - start single user dev chain" \
KMDICE "KMDICE - the mineable provably fair chain" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	REGTEST) submenu_regtest;;
	KMDICE) submenu_kmdice;;
	Exit) echo "Bye"; break;;
esac
done
