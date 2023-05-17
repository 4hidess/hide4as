
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
clear
data=(`find /var/log/ -name *.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done
data=(`find /var/log/ -name *.err`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done
data=(`find /var/log/ -name mail.*`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done
echo > /var/log/syslog
echo > /var/log/btmp
echo > /var/log/messages
echo > /var/log/debug
echo -e ""
read -n 1 -s -r -p " Press any key to back on menu"
menu
esac