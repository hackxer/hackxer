clear
echo "
#    #   ##    ####  #    # #    # ###### #####  
#    #  #  #  #    # #   #   #  #  #      #    # 
###### #    # #      ####     ##   #####  #    # 
#    # ###### #      #  #     ##   #      #####  
#    # #    # #    # #   #   #  #  #      #   #  
#    # #    #  ####  #    # #    # ###### #    # 
                                                 
                                                         
# #    #  ####  #####   ##   #      #      ###### #####  
# ##   # #        #    #  #  #      #      #      #    # 
# # #  #  ####    #   #    # #      #      #####  #    # 
# #  # #      #   #   ###### #      #      #      #####  
# #   ## #    #   #   #    # #      #      #      #   #  
# #    #  ####    #   #    # ###### ###### ###### #    # 

";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/hackxer"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/hackxer"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.hackxer"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory hackxer was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/hackxer*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/hackxer*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/alaabdellaoui" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/alaabdellaoui"
    else
        sudo rm -rf "$ETC_DIR/alaabdellaoui"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/hackxer/hackxer "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/hackxer.py" '${1+"$@"}' > "$INSTALL_DIR/hackxer";
chmod +x "$INSTALL_DIR/hackxers";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/hackxer" "$BIN_DIR"
    cp "$INSTALL_DIR/hackxer.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/hackxer" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/hackxer.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/hackxer";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing hackxer  !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
