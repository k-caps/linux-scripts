#!/bin/bash

# packages:
if [ -n "$(which apt)" ]; then
  printf  "\n\n*buntu detected, using apt\n\n"
  sudo apt update
  sudo apt install -y python-pip git powerline
elif [ -n "$(which yum)" ]; then
  printf "\n\nfedora/rhel/centos detected, using yum\n\n"
  sudo yum update
  sudo yum install -y python-pip git powerline
else
  echo Install the following packages and then manually continue the script from this point:
  echo powerline git python-pip
  exit
fi
# if powerline was not installed correctly via package manager
if [ -z "$(which powerline)" ]; then
  # if pip was installed attempt pip installation of powerline
  if [ -n "$(which python-pip)" ]; then
    pip install --user git+git://github.com/Lokaltog/powerline
  else
    # fallback to manual and unsupported git installation
    git clone https://github.com/powerline/fonts.git
  fi
fi  
# Hack font:
# If the script fails to install the font you can just download and install it manually from the link
  # (Modern distros can often install the .ttf file simply by doubleclicking it)
mkdir ~/.pline_install 
cd ~/.pline_install
git clone https://github.com/k-caps/Hackfont-serve.git
mkdir -p ~/.fonts
mv ./Hackfont-serve/'Hack Regular Nerd Font Complete.ttf' ~/.fonts/
fc-cache -fv ~/.fonts/

# bash:
if [ -n "$(which apt)" ]; then
  cat >> ~/.bashrc << EOF
    if [ -f `which powerline-daemon` ]; then
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      . /usr/share/powerline/bindings/bash/powerline.sh
    fi
EOF
else  [ -n "$(which yum)" ]
  cat >> ~/.bashrc << EOF
    if [ -f `which powerline-daemon` ]; then
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      . /usr/share/powerline/bash/powerline.sh
    fi
EOF
fi    
# vim:
cat >> ~/.vimrc << EOF

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
EOF
cd ~
rm -rf ~/.pline_install/
bash
