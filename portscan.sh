#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

# Variables de errores
syntax_error="\n${red}[!] La sintaxis de la IP o el rango de puertos es incorrecta${end}"
more_parameters="\n${red}[!] Esta herramienta acepta como máximo dos parámetros${end}"

function showInfo(){
  echo -e "\n${yellow}[+]${end} ${turquoise}Target IP:${end}${green} $1${end}"
  echo -e "\n${yellow}[+]${end} ${turquoise}Open ports:${end}${green} $2${end}"
  echo -e "\n${yellow}[+]${end} ${turquoise}Ports copied to clipboard${end}"
}

function ctrl_c(){
  echo -e "\n\n${red}[!] Saliendo...${end}"
  if [ -f "ports.tmp" ]; then
    findPorts="$(cat ports.tmp | sort -n | paste -sd ',')"
    echo -n $findPorts | xclip -sel clip
    showInfo $ip $findPorts
    rm ports.tmp
  fi
  kill $(jobs -p) &>/dev/null 
  tput cnorm; exit 1
}

# Ctrl + C
trap ctrl_c SIGINT

function helpPanel() {
  echo -e "\n${yellow}[+]${end}${purple} Uso:${end}"
  echo -e "\n\t${green}$0${end} ${turquoise}<IP>${end} ${yellow}<rango-puertos>${end} | ${turquoise}-h${end}"
  echo -e "\n${yellow}[+]${end}${purple} Ejemplo:${end}"
  echo -e "\n\t${green}$0${end} ${turquoise}192.168.1.1${end} ${yellow}1-10000${end}"
  echo -e "\n${yellow}[+]${end}${purple} Autor:${end} ${green}Jorge Arana Fedriani\n${end}"
  exit 1
}

if [ $1 ] && [ $2 ] && [ ! $3 ]; then
  ip=$1
  ports=$2

  ip_v="$(echo $ip | grep -oP '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$')"
  ports_v="$(echo $ports | grep -oP '^\d{1,5}\-\d{1,5}$')"

  if [ $ip_v ] && [ $ports_v ]; then
    start_port="$(echo $ports | awk '{print $1}' FS='-')"
    end_port="$(echo $ports | awk '{print $2}' FS='-')"

    if [ "$end_port" -gt 65535 ] || [ $start_port -ge $end_port ]; then
      echo -e $syntax_error
      helpPanel
    fi

    touch ports.tmp
    tput civis
    echo -e "\n${yellow}[+]${end}${turquoise} Iniciando el escaneo de puertos...\n${end}"
    for port in $(seq $start_port $end_port); do
      percentage=$((($port - $start_port) * 100 / ($end_port - $start_port)))
      echo -ne "\r${yellow}[+]${end} ${turquoise}Puerto${end} ${green}$port ${end}${purple}($percentage%)${end}"
      (timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" &>/dev/null && echo "$port" >> ports.tmp) &
    done; echo 

    find_ports="$(cat ports.tmp | sort -n | paste -sd ',')"

    echo -n $find_ports | xclip -sel clip

    showInfo $ip $find_ports

    rm ports.tmp &>/dev/null

    tput cnorm
  else
    echo -e $syntax_error
    helpPanel
  fi
else
  if [ $3 ]; then
    echo -e $more_parameters
  fi 
  helpPanel
fi

wait
