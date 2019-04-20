function bsk1n {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key. \n\
\n\
Choose the Seed or Mining Menu" 25 120 14 \
SEED-MENU "BSK - Single host - seed control" \
MINING-MENU "BSK - Single host -  mining control" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	SEED-MENU) bsk1n_seed_menu;;
	MINING-MENU) bsk1n_mining_menu;;
	Back) echo "Bye"; break;;
esac
done
}

function bsk1n_seed_menu {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - Seed Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
SEED-GETINFO "BSK-1node seed getinfo" \
NEW-NODE-SEED "Create a BSK-1node seed node" \
SHUTDOWN-NODE-SEED "Shutdown seed node" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-SEED) bsk1n_seed_spinup;;
	SEED-GETINFO) bsk1n_seed_getinfo;;
	SHUTDOWN-NODE-SEED) bsk1n_seed_shutdown;;
	Back) echo "Bye"; break;;
esac
done
}

function bsk1n_mining_menu {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - Mining Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
MINER-GETINFO "BSK-1node mining getinfo" \
MINING-START "BSK-1node start mining" \
MINING-STOP "BSK-1node mining stop" \
IMPORT-DEV-WALLET "BSK-1node import the dev wallet of this node" \
NEW-NODE-MINER "Create a BSK-1node first mining node" \
SHUTDOWN-NODE-MINER "Shutdown first mining node" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-MINER) bsk1n_mining_spinup;;
	MINER-GETINFO) bsk1n_mining_getinfo;;
	MINING-START) bsk1n_mining_start;;
	MINING-STOP) bsk1n_mining_stop;;
	IMPORT-DEV-WALLET) bsk1n_mining_importdevwallet;;
	SHUTDOWN-NODE-MINER) bsk1n_mining_shutdown;;
	Back) echo "Bye"; break;;
esac
done
}


function bsk1n_seed_getinfo {
  CHAIN="HELLOWORLD"
  METHOD="getinfo"
  if ps aux | grep -i [h]elloworld ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > /root/.$METHOD
    MSGBOXINFO=`cat /root/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_mining_getinfo {
  CHAIN="HELLOWORLD"
  METHOD="getinfo"
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > /root/.$METHOD
    MSGBOXINFO=`cat /root/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_seed_spinup {
    input_box "LEGS1" "How many coins?" "1000" SUPPLY
    input_box "LEGS3" "Ticker for chain?" "HELLOWORLD" NAME
    source ~/.devwallet
    echo $SUPPLY
    sleep 1
    echo $NAME
    sleep 1
    hide_output komodod -ac_name=$NAME -ac_supply=$SUPPLY -pubkey=$DEVPUBKEY &>/dev/null &
    sleep 1
    sleep 1
    source ~/.komodo/$NAME/$NAME.conf
    echo "Finishing seed node setup"
    sleep 1
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
    sleep 1
}

function bsk1n_mining_spinup {
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    echo "Already running a mining node"
    sleep 2
  else
    rm -Rf ~/coinData
    mkdir ~/coinData
    input_box "LEGS3" "Ticker for chain?" "HELLOWORLD" NAME
    mkdir ~/coinData/$NAME
    cp ~/.komodo/$NAME/$NAME.conf ~/coinData/$NAME
    sed -i 's/^\(rpcuser=\).*$/rpcuser=newname/' ~/coinData/$NAME/$NAME.conf
    sed -i 's/^\(rpcpassword=\).*$/rpcpassword=newpass/' ~/coinData/$NAME/$NAME.conf
    sed -i 's/^\(rpcport=\).*$/rpcport=1111/' ~/coinData/$NAME/$NAME.conf
    echo "port=1112" >> ~/coinData/$NAME/$NAME.conf
    hide_output komodod -ac_name=$NAME -ac_supply=1000 -datadir=/root/coinData/$NAME -addnode=localhost & #>/dev/null &
    echo "Finished mining node setup"
    echo "Ready to enable mining..."
    sleep 1
  fi
}

function bsk1n_mining_importdevwallet {
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    source /root/coinData/HELLOWORLD/HELLOWORLD.conf
    source ~/.devwallet
    echo "Importing $DEVADDRESS"
    sleep 2
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_start {
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    source /root/coinData/HELLOWORLD/HELLOWORLD.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [true,1]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    #echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_stop {
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    source /root/coinData/HELLOWORLD/HELLOWORLD.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [false]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    #echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_shutdown {
  if ps aux | grep -i [h]elloworld | grep coinData ; then
    source /root/coinData/HELLOWORLD/HELLOWORLD.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_seed_shutdown {
  source /root/.komodo/HELLOWORLD/HELLOWORLD.conf
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo $RESULT
  sleep 1
}
