#!/bin/bash

#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "${GREEN}loading...${NC}"
clear
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/4hidess/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "${GREEN}YOUR SCRIPT ACTIVE..${NC}"
    else
    echo -e "${RED}YOUR SCRIPT HAS EXPIRED!${NC}";
    echo -e "${RED}Please renew your ipvps first${NC}"
    exit 0
fi
}

if [ $MYIP = $MYIP ]; then
echo -e "${GREEN}Permission Accepted...${NC}"
VALIDITY
else
echo -e "${RED}Permission Denied!${NC}";
echo -e "${RED}Please buy script first${NC}"
exit 0
fi
echo -e "${GREEN}loading...${NC}"
clear
wsstunnel="$(cat ~/log-install.txt | grep -w "SSL(HTTPS)" | cut -d: -f2|sed 's/ //g')"
ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
ssl2="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}')"
echo -e "\e[0;34m.-----------------------------------------.${NC}"
echo -e "\e[0;34m|         \e[0;35mCHANGE PORT STUNNEL/SSL\e[m         \e[0;34m|${NC}"
echo -e "\e[0;34m'-----------------------------------------'${NC}"
echo -e " ${RED}>>${NC}${GREEN}Change Port For Stunnel4/SSL:${NC}"
echo -e "     [1]  Change Port $ssl"
echo -e "     [2]  Change Port $ssl2"
echo -e "======================================"
echo -e "     [x]  Back To Menu Change Port"
echo -e "     [y]  Go To Main Menu"
echo -e ""
read -p "     Select From Options [1-2 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $stl, $ssl2/g" /root/log-install.txt
sed -i "s/   - Websocket SSL(HTTPS)    : $ssl/   - Websocket SSL(HTTPS)    : $stl/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $stl modified successfully${NC}"
else
echo -e "${RED}Port $stl is used${NC}"
fi
;;
2)
read -p "New Port Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl2/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $ssl, $stl/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $stl modified successfully${NC}"
else
echo -e "${RED}Port $stl is used${NC}"
fi
;;
x)
clear
change-port
;;
y)
clear
menu
;;
*)
echo "Please enter an correct number"
;;
esac
