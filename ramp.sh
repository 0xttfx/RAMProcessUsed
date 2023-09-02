#!/bin/bash

RAM(){ 
  read -p 'Nome ou PID do rograma: ' prog
   
  if [[ ${prog} =~ ^[0-9]+$ ]]; then
    pids=$(echo ${prog} |xargs pmap -x |grep total|awk '{print $3}'| tr '\n' '+'|sed 's/.$//')&& echo $((${pids}))|numfmt --to=iec-i --suffix=B --format="%.2f";
  else
    pids=$(pidof ${prog} |xargs pmap -x |grep total|awk '{print $3}'| tr '\n' '+'|sed 's/.$//')&& echo $((${pids}))|numfmt --to=iec-i --suffix=B --format="%.2f";
  fi
}

RAM
