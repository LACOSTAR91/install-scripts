clear
function isRoot() {
  if [ "$EUID" -ne 0 ]; then
    return 1
  fi
}

function initialCheck() {
  if ! isRoot; then
    echo "Sorry, you need to run this as root"
    exit 1
  fi
  checkOS
}

function checkOS() {
    if [[ -e /etc/debian_version ]]; then
        OS="debian"
        source /etc/os-release

        if [[ "$ID" == "debian" || "$ID" == "raspbian" ]]; then
        if [[ ! $VERSION_ID =~ (10|9) ]]; then
            echo "⚠️ ${alert}Your version of Debian is not supported.${normal}"
            echo ""
            echo "However, if you're using older or unstable/testing then you can continue."
            echo "Keep in mind they may be no longer supported, though.${normal}"
            echo ""
            until [[ $CONTINUE =~ (y|n) ]]; do
            read -rp "Continue? [y/n] : " -e CONTINUE
            done
            if [[ "$CONTINUE" == "n" ]]; then
            exit 1
            fi
        fi
        elif [[ "$ID" == "ubuntu" ]]; then
        OS="ubuntu"
        if [[ ! $VERSION_ID =~ (20.04|22.04) ]]; then
            echo "⚠️ ${alert}Your version of Ubuntu is not supported.${normal}"
            echo ""
            echo "However, if you're using Older Ubuntu or beta, then you can continue."
            echo "Keep in mind they may be no longer supported, though.${normal}"
            echo ""
            until [[ $CONTINUE =~ (y|n) ]]; do
            read -rp "Continue? [y/n]: " -e CONTINUE
            done
            if [[ "$CONTINUE" == "n" ]]; then
            exit 1
            fi
        fi
        fi
    elif [[ -e /etc/centos-release ]]; then
        if ! grep -qs "^CentOS Linux release 7" /etc/centos-release; then
        echo "${alert}Your version of CentOS is not supported.${normal}"
        echo "${red}Keep in mind they are not supported, though.${normal}"
        echo ""
        unset CONTINUE
        until [[ $CONTINUE =~ (y|n) ]]; do
            read -rp "Continue? [y/n] : " -e CONTINUE
        done
        if [[ "$CONTINUE" == "n" ]]; then
            exit 1
        fi
        fi
    else
        echo "Looks like you aren't running this script on a Debian, Ubuntu or CentOS system ${normal}"
        exit 1
    fi
}

initialCheck
sudo apt install curl
curl -O https://raw.githubusercontent.com/LACOSTAR91/install-scripts/main/scripts/menu.bash

#Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
normal=$(tput sgr0)
alert=${white}${on_red}
on_red=$(tput setab 1)

source menu.bash

function displayMenu() {
    selected_item=0
    menu_items=${@:1:$#-1}
    run_menu "$selected_item" "${menu_items[@]}"
    menu_result="$?"

    echo
    "${@: -1}" $menu_result
}

function callback() {
    case "$1"
    in
        0)
            clear
            curl -O https://raw.githubusercontent.com/LACOSTAR91/install-scripts/main/scripts/nginx.sh | bash
            clear
            echo "$green Starting Nginx installation... $normal"
            bash nginx.sh
            ;;
        1)
            clear
            curl -O https://raw.githubusercontent.com/LACOSTAR91/install-scripts/main/scripts/nodejs.sh | bash
            clear
            echo "$green Starting Node.JS/NPM installation... $normal"
            bash nodejs.sh
            ;;
        2)
            clear
            curl -O https://raw.githubusercontent.com/LACOSTAR91/install-scripts/main/scripts/pma.sh | bash
            clear
            echo "$green Starting PHPMyAdmin installation... $normal"
            bash pma.sh
            ;;
        3)
            clear
            echo "Exit the script with success"
            ;;
    esac
}

displayMenu 'Nginx' 'Node.JS/NPM' 'PHPMyAdmin' 'Exit' callback