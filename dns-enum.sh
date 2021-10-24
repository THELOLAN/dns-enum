#! /bin/bash
#variables
day=$(date +%A)

#greeting message
greetings(){
echo "welcome $USER ! . today is $day . your using $SHELL shell for command exicution"
}
green=$(tput setaf 2)
reset=$(tput sgr0)
#enumerating record
function dns_enum {
for rec in A AAAA CNAME TXT MX; do
	echo "$rec record of $domain"
	dig $domain $rec +short
	echo "---------------------"
	
done
}

menu(){
	echo "1 - check ipv4"
	echo "2 - check ipv6"
	echo "3 - check CNAME record"
	echo "4 - check text record"
	echo "5 - check mail servers"
	echo "6 - check all"
	read -p "select option :" opt 

}

case_state(){
	case $opt in
	1 )
	ipv4=$(dig $domain A +short)
	echo "ipv4 of $domain is $ipv4";;
	2 )
	ipv6=$(dig $domain AAAA +short)
	echo "ipv6 of $domain is $ipv6";;
	3 )
	cname=$(dig $domain CNAME +short)
	echo "cname record of $domain is $cname";;
	4 )
	txt=$(dig $domain TXT +short)
	echo "txt record of $domain is $txt";;
	5 )
	mail=$(dig $domain MX +short)
	echo "mail servers of $domain is $mail";;
	6 )
	dns_enum;;
esac
}


greetings
read -p "enter the domain :" domain
menu
case_state
