#!/bin/bash

# Hack font:
# If the script fails to install the font you can just download and install it manually from the link
  # (Modern distros can often install the .ttf file simply by doubleclicking it)
git clone https://github.com/k-caps/Hackfont-serve.git
cd ./Hackfont-serve/

# For manual download you can click this drive link or download from the official git repository:
  # https://drive.google.com/file/d/1rKGE8jbO5iJPtatJPKqQ8rvT0BqlmfN8/view?usp=sharing
  # https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
mkdir -p ~/.fonts
mv 'Hack Regular Nerd Font Complete.ttf' ~/.fonts/
rm -f ../Hackfont-serve/
fc-cache -fv ~/.fonts/

# Now you neeeed to update your terminal app to use this font that we just installed, called "Hack Regular"

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
