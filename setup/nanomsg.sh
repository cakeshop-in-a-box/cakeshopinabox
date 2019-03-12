echo "Removing old nanomsg..."
rm -Rf ~/nanomsg
echo "Installing nanomsg..."
cd ~
hide_output git clone https://github.com/nanomsg/nanomsg
cd nanomsg
mkdir build
cd build
hide_output cmake .. -DNN_TESTS=OFF -DNN_ENABLE_DOC=OFF
hide_output cmake --build . 
hide_output sudo cmake --build . --target install
hide_output sudo ldconfig
cd $INSTALL_DIR
