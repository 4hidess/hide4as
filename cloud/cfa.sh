
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
rm -r /root/mail.conf
clear
cd /root
read -e -p " Masukan Domain :$domain" domain
read -e -p " Masukan Email Cloudflare :" email
read -e -p " Masukan Api Key :" key
echo -e "domain=$domain" >> /root/mail.conf
echo -e "email=$email" >> /root/mail.conf
echo -e "key=$key" >> /root/mail.conf
echo -e "### $domain $email" >> /root/mail.conf
clear
echo -e "${GREEN}DONE${NC}"
echo -e "\e[0;33mYour ID Cloudflare${NC}"
echo -e "\e[1;34m===============================${NC}"
echo -e "\e[0;36mDOMAIN         :${NC} $domain"
echo -e "\e[0;36mEmail          :${NC} $email"
echo -e "\e[0;36mApi Key        :${NC} $key"
echo -e "\e[1;34m===============================${NC}"
echo -e "${GREEN}Now you can use & add subdomain.${NC}"
echo -e "${GREEN}Go to main menu and chosee Add Subdomain to you ID Cloudflare or Pointing IP${NC}"
echo -e "${GREEN}to you ID Cloudflare${NC}"