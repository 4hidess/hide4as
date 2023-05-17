#!/bin/bash

GitUser="4hidess"
# Color Validation
LRED='\e[1;91m'
LGREEN='\e[92m'
LYELLOW='\e[93m'
GREEN='${GREEN}'
RED='\033[0;31m'
NC='\033[0m'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

clear
mkdir /var/lib/premium-script;
default_email=$( curl https://raw.githubusercontent.com/4hidess/email/main/default.conf )
clear
#Nama penyedia script
echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "   ${GREEN}Please enter the name of Provider for Script."
read -p "   Name : " nm
echo $nm > /root/provided
echo ""
#Email domain
echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "   ${GREEN}Please enter your email Domain/Cloudflare."
echo -e "   ${RED}(Press ENTER for default email)${NC}"
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi
# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "   ${GREEN}Please enter your subdomain "
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/premium-script/ipvps.conf
echo $host1 > /root/domain
echo ""

echo ""
clear
echo -e "${GREEN}READY FOR INSTALLATION SCRIPT...${NC}"
sleep 2
#install ssh ovpn
echo -e "${GREEN}INSTALLING SSH & OVPN...${NC}"
sleep 1
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
echo -e "${GREEN}DONE INSTALLING SSH & OVPN${NC}"
clear
#install Xray
echo -e "${GREEN}INSTALLING XRAY CORE...${NC}"
sleep 1
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/ins-xray.sh && chmod +x ins-xray.sh && screen -S ins-xray ./ins-xray.sh
echo -e "${GREEN}DONE INSTALLING XRAY CORE${NC}"
clear
#install ohp-server
echo -e "${GREEN}INSTALLING OHP PORT...${NC}"
sleep 1
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/ohp.sh && chmod +x ohp.sh && ./ohp.sh
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/ohp-dropbear.sh && chmod +x ohp-dropbear.sh && ./ohp-dropbear.sh
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/ohp-ssh.sh && chmod +x ohp-ssh.sh && ./ohp-ssh.sh
echo -e "${GREEN}DONE INSTALLING OHP PORT${NC}"
clear
#install websocket
echo -e "${GREEN}INSTALLING WEBSOCKET PORT...${NC}"
wget https://raw.githubusercontent.com/4hidess/hide4as/main/websocket-python/websocket.sh && chmod +x websocket.sh && screen -S websocket.sh ./websocket.sh
echo -e "${GREEN}DONE INSTALLING WEBSOCKET PORT${NC}"
clear
#install SET-BR
echo -e "${GREEN}INSTALLING SET-BR...${NC}"
sleep 1
wget https://raw.githubusercontent.com/4hidess/hide4as/main/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo -e "${GREEN}DONE INSTALLING SET-BR...${NC}"
clear
# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
# install clouflare JQ
apt install jq curl -y
# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/4hidess/hide4as/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/4hidess/hide4as/main/vps.conf"
/etc/init.d/nginx restart
#finish
rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/ohp.sh
rm -f /root/ohp-dropbear.sh
rm -f /root/ohp-ssh.sh
rm -f /root/websocket.sh
rm -f /root/set-br.sh
# Colour Default
echo "1;36m" > /etc/banner
echo "30m" > /etc/box
echo "1;31m" > /etc/line
echo "1;32m" > /etc/text
echo "1;33m" > /etc/below
echo "47m" > /etc/back
echo "1;35m" > /etc/number
echo 3d > /usr/bin/test
# Version
ver=$( curl https://raw.githubusercontent.com/4hidess/version/main/version.conf )
history -c
echo "$ver" > /home/ver
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo -e "${GREEN}══════════════════Autoscript givpn══════════════════${NC}" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI SSH & OpenVPN]" | tee -a log-install.txt
echo "    -------------------------" | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200"  | tee -a log-install.txt
echo "   - OpenVPN SSL             : 110"  | tee -a log-install.txt
echo "   - Stunnel4                : 222, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 143, 109"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8585"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8686"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8787"  | tee -a log-install.txt
echo "   - Websocket SSH(HTTP)     : 80"  | tee -a log-install.txt
echo "   - Websocket SSL(HTTPS)    : 443, 2096"  | tee -a log-install.txt
echo "   - Websocket OpenVPN       : 2097"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI Sqd, Bdvp, Ngnx]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8000 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI XRAY]"  | tee -a log-install.txt
echo "    ----------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Trojan Ws Tls      : 443"  | tee -a log-install.txt
echo "   - Xray Vless Tcp Xtls     : 443"  | tee -a log-install.txt
echo "   - Xray Trojan Tcp Tls     : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws None Tls  : 80"  | tee -a log-install.txt
echo "   - Xray Vless Ws None Tls  : 80"  | tee -a log-install.txt
echo "   - Xray Trojan Ws None Tls : 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI CLASH FOR ANDROID (YAML)]"  | tee -a log-install.txt
echo "    -----------------------------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Yaml      : Yes"  | tee -a log-install.txt
echo "   - Xray Vless Ws Yaml      : Yes"  | tee -a log-install.txt
echo "   - Xray Trojan Ws Yaml     : Yes"  | tee -a log-install.txt
echo "   --------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo -e "${GREEN}══════════════════Autoscript By givpn══════════════════${NC}" | tee -a log-install.txt
sleep 7
clear
echo ""
echo -e "    ${GREEN}.------------------------------------------.${NC}"
echo -e "    ${GREEN}|     SUCCESFULLY INSTALLED THE SCRIPT     |${NC}"
echo -e "    ${GREEN}|         Premium By givpn             |${NC}"
echo -e "    ${GREEN}'------------------------------------------'${NC}"
echo ""
echo -e "   ${GREEN}Your VPS Will Be Automatical Reboot In 5 seconds${NC}"
rm -r setup.sh
sleep 5
reboot
