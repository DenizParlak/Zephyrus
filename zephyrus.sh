#!/bin/bash

gr='\033[1;32m'
re='\033[1;31m'
xx='\033[0m'
yw='\033[1;33m'
bl='\033[0;34m'

apid1="1.1.1 Ensure that the --allow-privileged argument is set to false"
apid2="1.1.2 Ensure that the --anonymous-auth argument is set to false"
apid3="1.1.3 Ensure that the --basic-auth-file argument is not set"
apid4="1.1.4 Ensure that the --insecure-allow-any-token argument is not set"
apid5="1.1.5 Ensure that the --kubelet-https argument is set to true"
apid6="1.1.6 Ensure that the --insecure-bind-address argument is not set"
apid7="1.1.7 Ensure that the --insecure-port argument is set to 0"
apid8="1.1.8 Ensure that the --secure-port argument is not set to 0"
apid9="1.1.9 Ensure that the --profiling argument is set to false"
apid10="1.1.10 Ensure that the --repair-malformed-updates argument is set to false"
apid11="1.1.11 Ensure that the admission control policy is not set to AlwaysAdmit"
apid12="1.1.12 Ensure that the admission control policy is set to AlwaysPullImages"
apid13="1.1.13 Ensure that the admission control policy is set to DenyEscalatingExec"
apid14="1.1.14 Ensure that the admission control policy is set to SecurityContextDeny"
apid15="1.1.15 Ensure that the admission control policy is set to NamespaceLifecycle"
apid16="1.1.16 Ensure that the --audit-log-path argument is set as appropriate"
apid17="1.1.17 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate"
apid18="1.1.18 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate"
apid19="1.1.19 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate"
apid20="1.1.20 Ensure that the --authorization-mode argument is not set to AlwaysAllow"
apid21="1.1.20 Ensure that the --token-auth-file parameter is not set"
apid21b="1.1.21 Ensure that the --kubelet-certificate-authority argument is set as appropriate"
apid22="1.1.22 Ensure that the --kubelet-client-certificate and --kubelet-clientkey arguments are set as appropriate"
apid23="1.1.23 Ensure that the --service-account-lookup argument is set to true"
apid24="1.1.24 Ensure that the admission control policy is set to PodSecurityPolicy"
apid25="1.1.25 Ensure that the --service-account-key-file argument is set as appropriate"

# Cache kube-apiserver process arguments once to avoid spawning repeated ps/grep processes
KUBE_APISERVER_ARGS=$(ps -ef | grep '[k]ube-apiserver')

# Helper function: extracts the value of a flag (--flag=value) without spawning subshells
get_flag_val() {
  local flag="$1"
  local var_name="$2"
  if [[ " $KUBE_APISERVER_ARGS " =~ [[:space:]]--${flag}=([^[:space:]]+) ]]; then
    printf -v "$var_name" "%s" "${BASH_REMATCH[1]}"
  else
    printf -v "$var_name" "%s" ""
  fi
}

# Helper function: checks if a flag is present (--flag or --flag=value)
has_flag() {
  local flag="$1"
  if [[ " $KUBE_APISERVER_ARGS " =~ [[:space:]]--${flag}([=[:space:]]|$) ]]; then
    return 0
  else
    return 1
  fi
}

show(){
printf "${!1}\n"
}

usage(){
  echo "
      `basename $0` -s <> [ -h ] -- Zephyrus
  options:
      -h               help menu
      -s               single check
  "
  exit
}

while getopts ":hs:" OPTION; do
   case $OPTION in
     h )
        usage
        exit 1
        ;;
     s )
        checknum=$OPTARG
        ;;
     ? )
        echo ""
        echo "Invalid option"
        usage
        exit 1
        ;;
   esac
done

echo ""
echo "  _____          _                            "
echo " |__  /___ _ __ | |__  _   _ _ __ _   _ ___   "
echo "   / // _ \ '_ \| '_ \| | | | '__| | | / __|  "
echo "  / /|  __/ |_) | | | | |_| | |  | |_| \__ \  "
echo " /____\___| .__/|_| |_|\__, |_|   \__,_|___/  "
echo "          |_|          |___/                  "

echo -en '\n'
echo -en "____________________________________________________________"
echo -en '\n'
echo ""
echo -e "${bl}~ Kubernetes Auditing & Hardening Tool ~${xx}"
echo -en '\n'
echo -e "${re}denizparlak@protonmail.ch${xx}"
echo -e "${re}twitter.com/_denizparlak${xx}"
echo -en '\n'
echo -e "Zephyrus starting at.." `date`
echo -en "____________________________________________________________"
echo -en '\n'
echo ""
echo -en "${bl}Master Node Security Configurations Checking..${xx}"
echo ""
echo -en "${bl}               API Server${xx}"
echo ""
echo -en "____________________________________________________________"
echo ""

api1(){
  get_flag_val "allow-privileged" allow_priv
  if [[ "$allow_priv" == "false" || "$allow_priv" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid1}"
  else
    echo -e "${re}[WARN]${xx} ${apid1}"
  fi
}

echo ""
api1
echo -en '\n'

api2(){
  get_flag_val "anonymous-auth" anon_auth
  if [[ "$anon_auth" == "false" || "$anon_auth" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid2}"
  else
    echo -e "${re}[WARN]${xx} ${apid2}"
  fi
}

api2

api3(){
  get_flag_val "basic-auth-file" basic_aufi
  if [[ "$basic_aufi" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid3}"
  else
    echo -e "${re}[WARN]${xx} ${apid3}"
  fi
}

echo ""
api3
echo -en '\n'

api4(){
  get_flag_val "insecure-allow-any-token" ins_token
  if [[ "$ins_token" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid4}"
  else
    echo -e "${re}[WARN]${xx} ${apid4}"
  fi
}

api4
echo -en '\n'

api5(){
  get_flag_val "kubelet-https" kube_http
  if [[ "$kube_http" == "" || "$kube_http" == "true" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid5}"
  else
    echo -e "${re}[WARN]${xx} ${apid5}"
  fi
}

api5
echo -en '\n'

api6(){
  get_flag_val "insecure-bind-address" ins_bind
  if [[ "$ins_bind" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid6}"
  else
    echo -e "${re}[WARN]${xx} ${apid6}"
  fi
}

api6
echo -en '\n'

api7(){
  get_flag_val "insecure-port" ins_port
  if [[ "$ins_port" == "0" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid7}"
  else
    echo -e "${re}[WARN]${xx} ${apid7}"
  fi
}

api7
echo -en '\n'

api8(){
  get_flag_val "secure-port" sec_port
  if [[ "$sec_port" == "0" ]]; then
    echo -e "${re}[WARN]${xx} ${apid8}"
  else
    echo -e "${gr}[PASS]${xx} ${apid8}"
  fi
}

api8
echo -en '\n'

api9(){
  get_flag_val "profiling" prof
  if [[ "$prof" == "false" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid9}"
  else
    echo -e "${re}[WARN]${xx} ${apid9}"
  fi
}

api9
echo -en '\n'

api10(){
  get_flag_val "repair-malformed-updates" rep_malf
  if [[ "$rep_malf" == "false" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid10}"
  else
    echo -e "${re}[WARN]${xx} ${apid10}"
  fi
}

api10
echo -en '\n'

api11(){
  get_flag_val "admission-control" alw_admit
  if [[ "$alw_admit" == *AlwaysAdmit* ]]; then
    echo -e "${re}[WARN]${xx} ${apid11}"
  else
    echo -e "${gr}[PASS]${xx} ${apid11}"
  fi
}

api11
echo -en '\n'

api12(){
  get_flag_val "admission-control" alw_pull
  if [[ "$alw_pull" == *AlwaysPullImages* || "$alw_pull" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid12}"
  else
    echo -e "${re}[WARN]${xx} ${apid12}"
  fi
}

api12
echo -en '\n'

api13(){
  get_flag_val "admission-control" deny_esc
  if [[ "$deny_esc" == *DenyEscalatingExec* || "$deny_esc" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid13}"
  else
    echo -e "${re}[WARN]${xx} ${apid13}"
  fi
}

api13
echo -en '\n'

api14(){
  get_flag_val "admission-control" sec_cont
  if [[ "$sec_cont" == *SecurityContextDeny* || "$sec_cont" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid14}"
  else
    echo -e "${re}[WARN]${xx} ${apid14}"
  fi
}

api14
echo -en '\n'

api15(){
  get_flag_val "admission-control" namep_life
  if [[ "$namep_life" == *NamespaceLifecycle* || "$namep_life" == "" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid15}"
  else
    echo -e "${re}[WARN]${xx} ${apid15}"
  fi
}

api15
echo -en '\n'

api16(){
  get_flag_val "audit-log-path" aud_logpa
  if [[ "$aud_logpa" == "" ]]; then
    echo -e "${re}[WARN]${xx} ${apid16}"
  else
    echo -e "${gr}[PASS]${xx} ${apid16}"
  fi
}

api16
echo -en '\n'

api17(){
  get_flag_val "audit-log-maxage" aud_logmax
  if [[ -n "$aud_logmax" && "$aud_logmax" -ge 30 ]]; then
    echo -e "${gr}[PASS]${xx} ${apid17}"
  else
    echo -e "${re}[WARN]${xx} ${apid17}"
  fi
}

api17
echo -en '\n'

api18(){
  get_flag_val "audit-log-maxbackup" aud_logbac
  if [[ -n "$aud_logbac" && "$aud_logbac" -ge 10 ]]; then
    echo -e "${gr}[PASS]${xx} ${apid18}"
  else
    echo -e "${re}[WARN]${xx} ${apid18}"
  fi
}

api18
echo -en '\n'

api19(){
  get_flag_val "audit-log-maxsize" aud_logmsize
  if [[ -n "$aud_logmsize" && "$aud_logmsize" -ge 100 ]]; then
    echo -e "${gr}[PASS]${xx} ${apid19}"
  else
    echo -e "${re}[WARN]${xx} ${apid19}"
  fi
}

api19
echo -en '\n'

api20(){
  get_flag_val "authorization-mode" auth_mode
  if [[ "$auth_mode" == *AlwaysAllow* ]]; then
    echo -e "${re}[WARN]${xx} ${apid20}"
  else
    echo -e "${gr}[PASS]${xx} ${apid20}"
  fi
}

api20
echo -en '\n'

api21(){
  if has_flag "token-auth-file"; then
    echo -e "${re}[WARN]${xx} ${apid21}"
  else
    echo -e "${gr}[PASS]${xx} ${apid21}"
  fi
}

api21
echo -en '\n'

api21b(){
  if has_flag "kubelet-certificate-authority"; then
    echo -e "${gr}[PASS]${xx} ${apid21b}"
  else
    echo -e "${re}[WARN]${xx} ${apid21b}"
  fi
}

api21b
echo -en '\n'

api22(){
  if has_flag "kubelet-client-certificate"; then
    echo -e "${gr}[PASS]${xx} ${apid22}"
  else
    echo -e "${re}[WARN]${xx} ${apid22}"
  fi
}

api22
echo -en '\n'

api23(){
  get_flag_val "service-account-lookup" cert_key
  if [[ "$cert_key" == "true" ]]; then
    echo -e "${gr}[PASS]${xx} ${apid23}"
  else
    echo -e "${re}[WARN]${xx} ${apid23}"
  fi
}

api23
echo -en '\n'

api24(){
  get_flag_val "admission-control" adm_cont
  if [[ "$adm_cont" == *PodSecurityPolicy* ]]; then
    echo -e "${gr}[PASS]${xx} ${apid24}"
  else
    echo -e "${re}[WARN]${xx} ${apid24}"
  fi
}

api24
echo -en '\n'

api25(){
  if has_flag "service-account-key-file"; then
    echo -e "${gr}[PASS]${xx} ${apid25}"
  else
    echo -e "${re}[WARN]${xx} ${apid25}"
  fi
}

api25
echo -en '\n'

checkfunc(){
  if [[ $checknum ]];then
    case "$checknum" in
      api1 ) api1;;
      api2 ) api2;;
      * )
        echo "Invalid option";
    esac
    exit
  fi
}
