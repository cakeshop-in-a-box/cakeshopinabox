source setup/komodo.sh


if [ $DEBUG -eq 1 ]; then
	debug_info
	echo "BSK Setup"
	sleep 3
fi

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Komodo & Blockchain Starter Kit ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
KMD "Install Komodo Platform & Blockchain Starter Kit" \
SKIP "SKIP" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KMD) install_komodo;;
	SKIP) echo "NOBSK=1" >> /etc/cakeshopinabox.conf; NOBSK=1 ; echo "NOBSK=1";sleep 2; break;;
esac
done

