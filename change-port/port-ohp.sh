
GitUser="4hidess"
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
ohpssh="$(cat ~/log-install.txt | grep -w "OHP SSH" | cut -d: -f2|sed 's/ //g')"
ohpdrop="$(cat ~/log-install.txt | grep -w "OHP Dropbear" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[1;33m.-----------------------------------------.${NC}"
echo -e "\e[1;33m|         \e[0;36mCHANGE PORT OHP OPENSSH\e[m         \e[1;33m|${NC}"
echo -e "\e[1;33m'-----------------------------------------'${NC}"
echo -e " ${RED}>>${NC}${GREEN}Change Port For OHP OpenSSH:${NC}"
echo -e "     [1]  Change Port OHP SSH $ohpssh"
echo -e "     [2]  Change Port OHP Dropbear $ohpdrop"
echo -e "======================================"
echo -e "     [x]  Back To Menu Change Port"
echo -e "     [y]  Go To Main Menu"
echo -e ""
read -p "     Select From Options [1-2 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port OHP SSH: " vpn
if [ -z $vpn ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
rm -f /etc/systemd/system/ohps.service
cat > /etc/systemd/system/ohps.service <<END
[Unit]
Description=Direct Squid Proxy For open-ssh
Documentation=https://t.me/givpn
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohps -port $vpn -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END
systemctl daemon-reload
systemctl enable ohps
systemctl restart ohps
sed -i "s/   - OHP SSH                 : $ohpssh/   - OHP SSH                 : $vpn/g" /root/log-install.txt
echo -e "\e[032;1mPort $vpn modified successfully${NC}"
else
echo -e "${RED}Port OHP SSH $vpn is used${NC}"
fi
;;
2)
read -p "New Port OHP Dropbear: " vpn
if [ -z $vpn ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
rm -f /etc/systemd/system/ohpd.service
cat > /etc/systemd/system/ohpd.service <<END
[Unit]
Description=Direct Squid Proxy For Dropbear 
Documentation=https://t.me/givpn
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohpd -port $vpn -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:109
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END
systemctl daemon-reload
systemctl enable ohpd
systemctl restart ohpd
sed -i "s/   - OHP Dropbear            : $ohpdrop/   - OHP Dropbear            : $vpn/g" /root/log-install.txt
echo -e "\e[032;1mPort $vpn modified successfully${NC}"
else
echo -e "${RED}Port OHP Dropbear $vpn is used${NC}"
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