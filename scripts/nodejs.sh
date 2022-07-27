green=$(tput setaf 2)
normal=$(tput sgr0)

apt install sudo -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install build-essential -y
sudo apt install curl -y && curl -sL https://deb.nodesource.com/setup_16.x | bash - && sudo apt install build-essential nodejs -y
node -v
npm -v
sudo npm i -g pm2
rm nodejs.sh
clear
echo "$green Node.JS/NPM/PM2 successfully installed $normal"