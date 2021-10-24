#! /bin/bash

#provide domain

read -p "Enter the domain :" dom


#command exicution

cmd(){
    assetfinder -subs-only $dom >> assetresult.txt
    cat assetresult.txt | httprobe >> httprobe.txt
    rm assetresult.txt
}


#removing duplicate results and http:// https://

sorting(){

	file=httprobe.txt
    cp -r $file tmp_subs.txt
    while read url ; do
	     echo ${url#*//} >> urls.txt
    done < tmp_subs.txt
    sort -u urls.txt > $dom.txt
    count=$(cat httprobe.txt | wc -l)
    rm urls.txt
    rm tmp_subs.txt
    echo "SCRIPT EXICUTION COMPLETED"
    echo "Total ${count} subdomains Found " 
    echo "Output file saved as ${dom}.txt"
}

#if else condition when domain is empty 

if [[ -z $dom ]]; then
    echo "please provide a domain"
else
    cmd
    sorting
    rm httprobe.txt
fi
