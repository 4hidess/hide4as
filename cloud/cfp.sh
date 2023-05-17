
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
red='${RED}'
green='${GREEN}'
NC='${NC}'
MYIP=$(wget -qO- ifconfig.me/ip);
clear
# Acc ID Clf
mkdir -p /root/
touch /root/mail.conf
IP=$(wget -qO- ifconfig.me/ip);
cloudflare=$(grep -c -E "^### " "/root/mail.conf")
if [[ ${cloudflare} == '0' ]]; then
        echo ""
		echo ""
		echo -e "${RED}You Have No ID CLOUDFLARE! Please ADD ID Coudflare First.${NC}"
		echo -e "${RED}Back To Main Menu, Thankyou.${NC}"
		exit 1
	fi
source /root/mail.conf
DOMAIN=$domain
CF_ID=$email
CF_KEY=$key
set -euo pipefail
read -p "Masukan Subdomain Anda :" sub
read -p "Masukan Ip Yang Anda Ingin Pointing :" IP
echo "Updating DNS for ${sub}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${sub}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${sub}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${sub}'","content":"'${IP}'","ttl":120,"proxied":false}')
clear
echo ""
echo -e " \e[1;36mSuccesfully Add your Subdomain${NC}"
echo -e " \e[0;34m======================================${NC}"
echo -e " \e[0;33mDomain Name        :${NC} $DOMAIN"
echo -e " \e[0;33mSubdomain Name     :${NC} ${sub}"
echo -e " \e[0;33mYour IP Pointing   :${NC} ${IP}"
echo -e " \e[0;33mSub + Domain (Used):${NC} ${sub}.$DOMAIN"
echo -e " \e[0;34m======================================${NC}"
echo ""
echo -e "${GREEN}DONE...!${NC}"
