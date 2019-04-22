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
if [ $DEBUG -eq 1 ]; then
	./zcutil/fetch-params.sh
else
	hide_output ./zcutil/fetch-params.sh
fi
echo "Updating to latest komodo src..."
hide_output git pull
echo "Buidling komodo..."
hide_output ./zcutil/build.sh -j$(nproc)
localrev=$(git rev-parse HEAD)
sudo echo "KMD_BUILD_COMMIT=$localrev" >> /etc/cakeshopinabox.conf
sleep 5
cd ~
if [ ! -d ".komodo" ]; then
	echo "Creating komodo data dir .komodo"
	mkdir .komodo
fi
cd .komodo
if [ ! -f komodo.conf ]; then
	echo "Creating komodo.conf file"
	touch komodo.conf
	echo "Creating a random user id"
	rpcuser=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
	sleep 3
	echo "User created"
	echo "Creating a random password"
	rpcpassword=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
	echo "Password created"
	sleep 3
	echo "rpcuser=$rpcuser" > komodo.conf
	echo "rpcpassword=$rpcpassword" >> komodo.conf
	echo "daemon=1" >> komodo.conf
	echo "server=1" >> komodo.conf
	echo "txindex=1" >> komodo.conf
	chmod 0600 komodo.conf
else
	echo "Komodo config exists..."
	sleep 5
fi
cd ~
echo "Komodo will now be available from anywhere in the system"
sudo ln -sf $KMD_SRC/src/komodo-cli /usr/local/bin/komodo-cli
sudo ln -sf $KMD_SRC/src/komodod /usr/local/bin/komodod
sleep 2
echo "Get ready to select chains to sync!!"
sleep 3

