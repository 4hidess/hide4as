
GitUser="4hidess"
#Direct Proxy Squid For OpenVPN TCP
RED='${RED}'
GREEN='${GREEN}'
BLUE='\e[0;34m'
NC='${NC}'
MYIP=$(wget -qO- https://icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

#Update Repository VPS
clear
apt update 
apt-get -y upgrade

#Port Server ovpn ohp
#Jika Ingiin Mengubah Port Silahkan Sesuaikan Dengan Port Yang Ada Di VPS Mu
Port_OpenVPN_TCP='22';
Port_Squid='3128';
Port_OHP='8686';

#Installing ohp Server
cd 
wget -O /usr/local/bin/ohps "https://raw.githubusercontent.com/4hidess/hide4as/main/ohps"
chmod +x /usr/local/bin/ohps

#Buat Service Untuk OHP SSH
cat > /etc/systemd/system/ohps.service <<END
[Unit]
Description=Direct Squid Proxy For open-ssh
Documentation=https://t.me/givpn
Wants=network.target
After=network.target

[Service]
ExecStart=/usr/local/bin/ohp -port 8686 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohps
systemctl restart ohps
echo ""
echo -e "${GREEN}Done Installing OHP OpenSSH${NC}"
echo -e "Port OHP OpenSSH: $ohpp"
