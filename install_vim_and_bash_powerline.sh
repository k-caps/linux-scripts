#!/bin/bash

# Hack font:
# (Modern distros can often install the .ttf file simply by doubleclicking it)
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
mkdir -p ~/.fonts
mv 'Hack Regular Nerd Font Complete.ttf' ~/.fonts/
fc-cache -fv ~/.fonts/

# Now you neeeed to update your terminal app to use this font called "Hack Regular"
# packages UBUNTU ONLY:
sudo apt update
sudo apt-get install python-pip git powerline
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
