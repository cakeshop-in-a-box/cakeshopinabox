function install_hush3 {
cd ~
CHAIN=HUSH3
#echo "Removing old HUSH3 dir..."
#rm -Rf ~/komodo
if [ ! -d "hush3" ]; then
	echo "Begin $CHAIN installation..."
	cd ~
	hide_output git clone https://github.com/MyHush/hush3
fi
cd hush3
HUSH3_SRC=`pwd`
hide_output git checkout dev
echo "Fetching zcash parameters..."
hide_output ./zcutil/fetch-params.sh
#echo "Updating to latest hush3 src..."
#hide_output git pull
echo "Buidling hush3..."
hide_output ./zcutil/build.sh -j$(nproc)
localrev=$(git rev-parse HEAD)
sudo echo "HUSH3_BUILD_COMMIT=$localrev" >> /etc/cakeshopinabox.conf
sleep 3
cd ~
if [ ! -d ".komodo" ]; then
	echo "Creating komodo data dir .komodo"
	mkdir .komodo
fi
cd .komodo
mkdir $CHAIN
cd $CHAIN
if [ ! -f $CHAIN.conf ]; then
	echo "Creating $CHAIN.conf file"
	touch $CHAIN.conf
	echo "Creating a random user id"
	rpcuser=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
	sleep 1
	echo "User created"
	echo "Creating a random password"
	rpcpassword=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
	echo "Password created"
	sleep 3
	echo "rpcuser=$rpcuser" > $CHAIN.conf
	echo "rpcpassword=$rpcpassword" >> $CHAIN.conf
	echo "daemon=1" >> $CHAIN.conf
	echo "server=1" >> $CHAIN.conf
	echo "txindex=1" >> $CHAIN.conf
	echo "rpcworkqueue=127.0.0.1" >> $CHAIN.conf
	echo "rpcallowip=127.0.0.1" >> $CHAIN.conf
	echo "rpcport=18031" >> $CHAIN.conf
	chmod 0600 $CHAIN.conf
else
	echo "$CHAIN config exists..."
	sleep 3
fi
cd ~
echo "$CHAIN will now be available from anywhere in the system"
sudo ln -sf $HUSH3_SRC/src/hush-cli /usr/local/bin/hush-cli
sudo ln -sf $HUSH3_SRC/src/hushd /usr/local/bin/hushd
sleep 2
echo "Get ready to select chains to sync!!"
sleep 3

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Start blockchain" \
--title "[ S Y N C - C H A I N ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
HUSH3 "Sync & Start HUSH3" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	HUSH3) start_hush3;;
	Exit) echo "Bye"; break;;
esac
done
}


function submenu_hush3 {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ H U S H 3 - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
HUSH3_GETINFO "Get Info - HUSH3 getinfo method" \
HUSH3_LISTUNSPENT "List Unspent UTXO - HUSH3 listunspent" \
HUSH3_GETPEERINFO "Get Network Info - HUSH3 getpeerinfo" \
HUSH3_GETMININGINFO "Get Mining Info - HUSH3 getmininginfo" \
HUSH3_DELETE "Experimental - Delete blockchain data" \
HUSH3_START "Start HUSH3" \
HUSH3_STOP "Stop HUSH3" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	HUSH3_DELETE) delete_blockchain_data_hush3;;
	HUSH3_START) start_hush3;;
	HUSH3_STOP) stop_hush3;;
	HUSH3_GETINFO) getinfo_hush3;;
	HUSH3_GENERATE) generate_hush3;;
	HUSH3_LISTUNSPENT) listunspent_hush3;;
	HUSH3_GETPEERINFO) getpeerinfo_hush3;;
	HUSH3_GETMININGINFO) getmininginfo_hush3;;
	Back) echo "Bye"; break;;
esac
done
}
