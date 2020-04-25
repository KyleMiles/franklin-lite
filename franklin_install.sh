pacman -Syu
pacman -Syy git python python-pip wget fakeroot sudo make base-devel arduino-cli

pip install git+https://github.com/wijnen/python-fhs.git
pip install git+https://github.com/wijnen/python-network.git
pip install git+https://github.com/wijnen/python-websocketd.git

git clone https://github.com/mtu-most/franklin.git
