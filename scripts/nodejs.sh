source index.sh
apt install sudo -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install build-essential -y
sudo apt install curl -y && curl -sL https://deb.nodesource.com/setup_16.x | bash - && sudo apt install build-essential nodejs -y
node -v
npm -v
sudo npm i -g pm2
clear
echo "$green Node.JS/NPM/PM2 successfully installed $normal"