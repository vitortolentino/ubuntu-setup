clear
yellow=`tput setaf 11`
resetColor=`tput sgr0`

echo "${yellow}Initializing instalations"
echo "updating packages${resetColor}"
sudo apt-get update
clear

echo "${yellow}Installing curl${resetColor}"
sudo apt install curl -y
clear

echo "${yellow}Installing zsh${resetColor}"
sudo apt-get install zsh -y

echo "${yellow}Installing git${resetColor}"
sudo apt install git -y
clear

echo "${yellow}Installing Oh My Zsh${resetColor}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
clear

echo "${yellow}What name do you want to use in GIT user.name?${resetColor}"
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear 

echo "${yellow}What email do you want to use in GIT user.email?${resetColor}"
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo "${yellow}Installing vim${resetColor}"
sudo apt install vim -y
clear

echo "${yellow}Setting VIM as core editor${resetColor}"
git config --global core.editor vim
clear

echo "${yellow}Installing tool to handle clipboard via CLI${resetColor}"
sudo apt-get install xclip -y
clear

echo "${yellow}Generating a SSH Key${resetColor}"
mkdir ~/.ssh
(cd ~/.ssh && ssh-keygen -t rsa -b 4096 -C $git_config_user_email)
clear

echo "${yellow}What name of genereted ssh?${resetColor}"
read ssh_name
ssh-add ~/.ssh/$ssh_name
cat ~/.ssh/$ssh_name.pub | xclip -selection clipboard
echo "${yellow}ssh pub copied to clipboard${resetColor}"

echo "${yellow}Enabling workspaces for both screens${resetColor}"
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo "${yellow}Installing Visual Studio Code${resetColor}"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

echo "${yellow}Installing extensions${resetColor}"
code --install-extension dbaeumer.vscode-eslint
code --install-extension christian-kohler.path-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension dracula-theme.theme-dracula
code --install-extension esbenp.prettier-vscode
code --install-extension foxundermoon.shell-format
code --install-extension pmneo.tsimporter
code --install-extension waderyan.gitblame
code --install-extension yzhang.markdown-all-in-one
clear

echo "${yellow}Installing chrome${resetColor}"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
clear

echo "${yellow}Installing nvm${resetColor}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
clear

source ~/.zshrc
nvm --version
nvm install 20
nvm alias default 20
clear

echo "${yellow}installing autosuggestions${resetColor}"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshr
source ~/.zshrc
clear

echo "${yellow}installing theme${resetColor}"
sudo apt install fonts-firacode -y
wget -O ~/.oh-my-zsh/themes/node.zsh-theme https://raw.githubusercontent.com/skuridin/oh-my-zsh-node-theme/master/node.zsh-theme 
sed -i 's/.*ZSH_THEME=.*/ZSH_THEME="node"/g' ~/.zshrc
clear

echo "${yellow}installing slack${resetColor}"
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.8-amd64.deb
sudo apt install ./slack-desktop-*.deb -y
clear

echo "${yellow}installing terminator${resetColor}"
sudo apt-get update
sudo apt-get install terminator -y
clear

echo "${yellow}adding dracula theme${resetColor}"
cat <<EOF >  ~/.config/terminator/config
[global_config]chr
  title_transmit_bg_color = "#ad7fa8"
[keybindings]
  close_term = <Primary>w
  close_window = <Primary>q
  new_tab = <Primary>t
  new_window = <Primary>i
  paste = <Primary>v
  split_horiz = <Primary>e
  split_vert = <Primary>d
  switch_to_tab_1 = <Primary>1
  switch_to_tab_10 = <Primary>0
  switch_to_tab_2 = <Primary>2
  switch_to_tab_3 = <Primary>3
  switch_to_tab_4 = <Primary>4
  switch_to_tab_5 = <Primary>5
  switch_to_tab_6 = <Primary>6
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
EOF

cat <<EOF >>  ~/.config/terminator/config
[[Dracula]]
    background_color = "#1e1f29"
    background_darkness = 0.88
    background_type = transparent
    copy_on_selection = True
    cursor_color = "#bbbbbb"
    foreground_color = "#f8f8f2"
    palette = "#000000:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#bbbbbb:#555555:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#ffffff"
    scrollback_infinite = True
EOF
clear

echo "${yellow}installing docker${resetColor}"
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker --version

chmod 777 /var/run/docker.sock
docker run hello-world
clear

echo "${yellow}installing docker-compose${resetColor}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
clear

echo "${yellow}installing dbeaver${resetColor}"
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f
clear

echo "${yellow}installing gnome twitch${resetColor}"
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update && sudo apt install gnome-twitch
clear

echo "${yellow}installing discord${resetColor}"
wget -O ~/Downloads/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i ~/Downloads/discord.deb
clear

echo "${yellow}installing htop${resetColor}"
sudo apt-get install htop
clear

echo "${yellow}installing insomnia${resetColor}"
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

sudo apt-get update
sudo apt-get install insomnia
clear

echo "${yellow}installing MongoDB Compass${resetColor}"
wget -O ~/Downloads/compass.deb "https://downloads.mongodb.com/compass/mongodb-compass_1.21.2_amd64.deb"
sudo dpkg -i ~/Downloads/compass.deb
clear

echo "${yellow}End of instalations${resetColor}"
