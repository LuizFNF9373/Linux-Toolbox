#!/bin/bash
txt="Funções disponíveis do"
loggen="Você quer gerar um log? (S/N): "
toolfunc="Digite a função da ferramenta disponível: "
err="Opção inválida!"
data=$(date +%Y%m%d-%H%M%S)
while true; do
 printf "Ferramentas disponíveis:\n[1] Suricata\n[2] Chkrootkit\n[3] Fail2ban\n[4] Lynis\n[0] Sair\n"
 read -p "$toolfunc" initoption
 case "$initoption" in
 1)
  echo ${txt} "Suricata"
  printf "[1] Baixar regras (sudo suricata-update)\n[2] Verificar logs (tail -f /var/log/suricata/eve.json)\n"
  read -p "$toolfunc" suboption
  case "$suboption" in
   1)
    read -p "$loggen" log
    log=${log,,}
    if [[ "$log" =~ ^(n|nao|não)$ ]]; then
     sudo suricata-update
    elif [[ "$log" =~ ^(s|sim)$ ]]; then
     sudo suricata-update | tee suricata-update-log-$data.txt
    else
    echo "$err"
    fi ;;
   2)
   less /var/log/suricata/eve.json ;;
   esac ;;
 2)
  echo ${txt} "Chkrootkit"
  printf "[1] Escanear o sistema a busca de rootkits (sudo chkrootkit)\n"
  read -p "$toolfunc" suboption 
  read -p "$loggen" log
  log=${log,,}
  if [[ "$log" =~ ^(n|nao|não)$ ]]; then
   sudo chkrootkit
  elif [[ "$log" =~ ^(s|sim)$ ]]; then
   sudo chkrootkit | tee chkrootkit-log-$data.txt
  else
  echo "Opção inválida!"
  fi ;;
 3)
  echo ${txt} "Fail2ban"
  printf "[1] Verificar bans do SSH (sudo fail2ban-client status sshd)\n"
  read -p "$toolfunc" suboption
  read -p "$loggen" log
  clear
  log=${log,,}
  if [[ "$log" =~ ^(n|nao|não)$ ]]; then
   sudo fail2ban-client status sshd
  elif [[ "$log" =~ ^(s|sim)$ ]]; then
   sudo fail2ban-client status sshd | tee fail2ban-log-$data.txt
  else
  echo "ERRO!" 
  fi ;;
 4)
  echo ${txt} "Lynis"
  printf "[1] Inspencionar o sistema (sudo lynis audit system)\n"
  read -p "$toolfunc" suboption
  read -p "$loggen" log
  log=${log,,}
  if [[ "$log" =~ ^(n|nao|não)$ ]]; then
   sudo lynis audit system
  elif [[ "$log" =~ ^(s|sim)$ ]]; then
   sudo lynis audit system | tee lynis-log-$data.txt
  else
  echo "ERRO!"
  fi ;;
 0) exit 0 ;;
 *) echo "$err";;
 esac
done