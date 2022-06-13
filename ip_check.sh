#!/usr/bin/env bash

ip_list=`journalctl | grep sshd | grep -E "Disconnected from authenticating|Disconnected from invalid"  | sed -E 's/.*Disconnected from (authenticating |invalid ) ?user (.*) ([0-9.]*)+ port [0-9]+( \[preauth\])?$/\3/' | sort | uniq -c | sort -nr`
check_url="https://ipinfo.io/"
result="count,ip_address,lat,long\n"
for ip in  $ip_list;
    do  if [[ ${#ip} -lt 5 ]];
        then 
        result+="${ip},"
    else
    response=$(curl "${check_url}${ip}?token=3abb0f708bae48") 
    loc=$(echo $response | sed -E 's/.*"loc": "([0-9.,-]*).*/\1/')
    result+="${ip},${loc}\n"
    fi
done

printf $result > fraud_login.csv
