#!/bin/bash

# Hack font:
# If the script fails to install the font you can just download and install it manually from the link
  # (Modern distros can often install the .ttf file simply by doubleclicking it)
git clone https://github.com/k-caps/Hackfont-serve.git
cd ./Hackfont-serve/
mkdir -p ~/.fonts
mv 'Hack Regular Nerd Font Complete.ttf' ~/.fonts/
rm -rf ../Hackfont-serve/
fc-cache -fv ~/.fonts/

# packages:
if [ -n "$(which apt)" ]; then
  sudo apt update
  sudo apt-get install python-pip git powerline
elif [ -n "$(which dnf)" ]; then
  sudo dnf update
  sudo dnf install powerline
else
  echo Install the following packages and then manually continue the script from this point:
  echo powerline git python-pip
fi
pip install --user git+git://github.com/Lokaltog/powerline
# bash:
cat >> ~/.bashrc << EOF

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
fi
EOF

# vim:
cat >> /etc/vim/vimrc << EOF

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=25
EOF

source ~/.bashrc
