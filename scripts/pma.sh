green=$(tput setaf 2)
normal=$(tput sgr0)

mkdir /var/www/mysql.lacostar.fr
tar xzf phpMyAdmin-* --strip-components=1 -C /var/www/mysql.lacostar.fr
cp /var/www/mysql.lacostar.fr/config{.sample,}.inc.php
nano /var/www/mysql.lacostar.fr/config.inc.php
chmod 660 /var/www/mysql.lacostar.fr/config.inc.php
chown -R www-data:www-data /var/www/mysql.lacostar.fr
systemctl restart nginx
rm pma.sh
clear
echo "$green PHPMyAdmin successfully installed $normal"