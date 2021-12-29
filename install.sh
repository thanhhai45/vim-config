setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

setup_color

TEST=`cat /etc/os-release | grep arch`

# Check if arch or debian

if [ $TEST ]
then
	echo "${BLUE} Detected OS :${RESET} ${GREEN}Arch${RESET}."
	sudo pacman -S git vim vifm neovim bat ripgrep -y
else
	echo "${BLUE} Detected OS :${RESET} ${GREEN}Ubuntu${RESET}."
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt install git vim vifm neovim -y
fi

# Install Vim-plug
# For Nvim
echo "${BLUE}Installing Nvim...${RESET}"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "${BLUE}Configuring...${RESET}"

mv ~/.config/nvim ~/.config/nvim.bak
mkdir ~/.config/nvim

ln -s $PWD/* ~/.config/nvim/


nvim -c 'PlugInstall' \
	-c 'qa'

nvim -c 'CocInstall coc-css coc-cssmodules coc-emmet coc-eslint coc-explorer
coc-floaterm coc-git coc-html coc-html-css-support coc-htmlhint coc-json
coc-solargraph coc-dot-complete coc-css coc-rome coc-tabnine coc-stylelintplus' \
    -c 'qa'
