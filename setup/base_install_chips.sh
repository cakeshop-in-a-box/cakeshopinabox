function submenu_install_chips {
STAGE="Install CHIPS"

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console - ${STAGE}" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
CHIPS "CHIPS - install the decentralized peer-to-peer blockchain backend" \
LIGHTNING "LIGHTNING - install lightning for cheap microtransactions" \
PANGEA "PANGEA - install the front end GUI web application" \
Back "Go back in the menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
        LIGHTNING) install_lightning;;
        CHIPS) install_chips;;
        PANGEA) install_pangea;;
        Back) echo "Bye"; break;;
esac
done
}

function install_lightning {
cd $HOME
#sudo apt-get -y install software-properties-common autoconf git build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake libboost-all-dev automake jq libdb++-dev
git clone https://github.com/jl777/lightning
cd lightning
make
sudo ln -sf ${PWD}/lightningd/lightningd /usr/local/bin/lightning
}

function install_chips {
cd $HOME
sudo apt-get -y install software-properties-common autoconf git build-essential libtool libprotobuf-c-dev libgmp-dev libsqlite3-dev python python3 zip jq libevent-dev pkg-config libssl-dev libcurl4-gnutls-dev cmake libboost-all-dev automake jq 
git clone https://github.com/jl777/chips3.git
cd chips3
CHIPSDIR=$PWD
echo "CHIPSDIR is $CHIPSDIR"
sleep 3
git checkout dev
wget https://github.com/imylomylo/docker-chipsd-lightning/raw/master/db-4.8.30.NC.tar.gz
tar zxvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
../dist/configure -enable-cxx -disable-shared -with-pic -prefix=${CHIPSDIR}/db4
make -j2
sudo make install
cd $HOME
cd chips3
./autogen.sh
./configure LDFLAGS="-L${CHIPSDIR}/db4/lib/" CPPFLAGS="-I${CHIPSDIR}/db4/include/" -without-gui -without-miniupnpc --disable-tests --disable-bench --with-gui=no && \
make -j2
sudo ln -sf ${PWD}/src/chipsd /usr/local/bin/chipsd
sudo ln -sf ${PWD}/src/chips-cli /usr/local/bin/chips-cli
}

function install_pangea {
echo "Not implemented"
}
