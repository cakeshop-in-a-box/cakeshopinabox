function bsk1n {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
BSK1NSEEDNODE "Create a BSK-1node seed node" \
BSK1NMININGNODE "Create a BSK-1node first mining node" \
BSK1NSETGENERATE "BSK-1node start mining" \
BSK1NSEEDGETINFO "BSK-1node seed getinfo" \
BSK1NMININGGETINFO "BSK-1node mining getinfo" \
BSK1NMININGSTOP "BSK-1node mining stop" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	BSK1NSEEDNODE) bsk1n_seednode;;
	BSK1NMININGNODE) bsk1n_miningnode;;
	BSK1NSEEDGETINFO) bsk1n_seed_getinfo;;
	BSK1NMININGGETINFO) bsk1n_mining_getinfo;;
	BSK1NSETGENERATE) bsk1n_setgenerate;;
	BSK1NMININGSTOP) bsk1n_miningnodestop;;
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
  if ps aux | grep -i [h]elloworld ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > /root/.$METHOD
    MSGBOXINFO=`cat /root/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_seednode {
    input_box "LEGS1" "How many coins?" "1000" SUPPLY
    input_box "LEGS3" "Ticker for chain?" "HELLOWORLD" NAME
    source ~/.devwallet
    echo $SUPPLY
    sleep 1
    echo $NAME
    sleep 1
    hide_output komodod -ac_name=$NAME -ac_supply=$SUPPLY -pubkey=$DEVPUBKEY &
    sleep 1
    sleep 1
    source ~/.komodo/$NAME/$NAME.conf
    echo "Finishing seed node setup"
    sleep 1
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
    sleep 2
}

function bsk1n_miningnode {
  rm -Rf ~/coinData
  mkdir ~/coinData
  input_box "LEGS3" "Ticker for chain?" "HELLOWORLD" NAME
  mkdir ~/coinData/$NAME
  cp ~/.komodo/$NAME/$NAME.conf ~/coinData/$NAME
  sed -i 's/^\(rpcuser=\).*$/rpcuser=newname/' ~/coinData/$NAME/$NAME.conf
  sed -i 's/^\(rpcpassword=\).*$/rpcpassword=newpass/' ~/coinData/$NAME/$NAME.conf
  sed -i 's/^\(rpcport=\).*$/rpcport=1111/' ~/coinData/$NAME/$NAME.conf
  echo "port=1112" >> ~/coinData/$NAME/$NAME.conf
  komodod -ac_name=$NAME -ac_supply=1000 -datadir=/root/coinData/$NAME -addnode=localhost &
  echo "Finished mining node setup"
  echo "Ready to enable mining..."
  bsk1n_setgenerate
  sleep 2
}

function bsk1n_setgenerate {
  source /root/coinData/HELLOWORLD/HELLOWORLD.conf
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [true,1]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo $RESULT
}

function bsk1n_miningnodestop {
  source /root/coinData/HELLOWORLD/HELLOWORLD.conf
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo $RESULT
}
