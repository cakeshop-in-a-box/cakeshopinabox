cd ~
#echo "Removing old komodo dir..."
#rm -Rf ~/komodo
if [ ! -d "komodo" ]; then
	echo "Begin komodo installation..."
	cd ~
	hide_output git clone https://github.com/komodoplatform/komodo.git
fi
cd komodo
KMD_SRC=`pwd`
hide_output git checkout dev
echo "Fetching zcash parameters..."
hide_output ./zcutil/fetch-params.sh
echo "Updating to latest komodo src..."
hide_output git pull
echo "Buidling komodo..."
hide_output ./zcutil/build.sh -j$(nproc)
localrev=$(git rev-parse HEAD)
sudo echo "KMD_BUILD_COMMIT=$localrev" >> /etc/cakeshopinabox.conf
cd ~
if [ ! -d ".komodo" ]; then
	echo "Creating komodo data dir .komodo"
	mkdir .komodo
fi
cd .komodo
if [ ! -f komodo.conf ]; then
	touch komodo.conf
	rpcuser=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)
	rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)
	echo "rpcuser=$rpcuser" > komodo.conf
	echo "rpcpassword=$rpcpassword" >> komodo.conf
	echo "daemon=1" >> komodo.conf
	echo "server=1" >> komodo.conf
	echo "txindex=1" >> komodo.conf
	chmod 0600 komodo.conf
else
	echo "Komodo config exists..."
fi
cd ~
echo "Komodo will now be available from anywhere in the system"
sudo ln -sf $KMD_SRC/src/komodo-cli /usr/local/bin/komodo-cli
sudo ln -sf $KMD_SRC/src/komodod /usr/local/bin/komodod

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Start blockchain" \
--title "[ S Y N C - C H A I N ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
KMD "Sync & Start Komodo" \
KMDICE "Sync & Start KMDICE" \
CAKESHOP "Sync & Start CAKESHOP - KMD ARCADE" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KMD) start_komodo;;
	KMDICE) start_kmdice;;
	Exit) echo "Bye"; break;;
esac
done
