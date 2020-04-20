#!/bin/bash

# Hack font:
# (Modern distros can often install the .ttf file simply by doubleclicking it)
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
mkdir -p ~/.fonts
mv 'Hack Regular Nerd Font Complete.ttf' ~/.fonts/
fc-cache -fv


# Now you neeeed to update your terminal app to use this font called "Hack Regular"

sudo pip install git+git://github.com/Lokaltog/powerline
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
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
EOF
