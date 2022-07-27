source index.sh
apt update -y && apt upgrade -y
apt install sudo -y
sudo apt install curl gnupg2 ca-certificates lsb-release ufw -y
sudo apt install nginx -y
clear
echo "$green Nginx successfully installed $normal"