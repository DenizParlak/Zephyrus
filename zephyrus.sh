#!/bin/bash

gr='\033[1;32m'
re='\033[1;31m'
xx='\033[0m'
yw='\033[1;33m'
bl='\033[0;34m'

KUBE_APISERVER_ARGS=$(ps -ef | grep kube-apiserver | grep -v grep)

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
# Performance Optimization: Using cached KUBE_APISERVER_ARGS and Bash internal regex matching
# to avoid spawning redundant 'ps', 'grep', and 'awk' processes.
local allow_priv=""
if [[ $KUBE_APISERVER_ARGS =~ --allow-privileged=([^[:space:],]+) ]]; then
  allow_priv="${BASH_REMATCH[1]}"
fi

if [[ "$allow_priv" == "false" || "$allow_priv" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid1`
else
  echo -en "${re}[WARN]${xx}" `show apid1`
fi
}

echo ""
api1
echo -en '\n'

api2(){
local anon_auth=""
if [[ $KUBE_APISERVER_ARGS =~ --anonymous-auth=([^[:space:],]+) ]]; then
  anon_auth="${BASH_REMATCH[1]}"
fi

if [[ "$anon_auth" == "false" || "$anon_auth" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid2`
else
  echo -en "${re}[WARN]${xx}" `show apid2`
fi
}

api2

api3(){
local basic_aufi=""
if [[ $KUBE_APISERVER_ARGS =~ --basic-auth-file=([^[:space:],]+) ]]; then
  basic_aufi="${BASH_REMATCH[1]}"
fi

# Fix: Variable basic_aufi was incorrectly checked as anon_auth
if [[ "$basic_aufi" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid3`
else
  echo -en "${re}[WARN]${xx}" `show apid3`
fi
}

echo ""
api3
echo -en '\n'

api4(){
local ins_token=""
if [[ $KUBE_APISERVER_ARGS =~ --insecure-allow-any-token=([^[:space:],]+) ]]; then
  ins_token="${BASH_REMATCH[1]}"
fi

if [[ "$ins_token" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid4`
else
  echo -en "${re}[WARN]${xx}" `show apid4`
fi
}

api4
echo -en '\n'

api5(){
local kube_http=""
if [[ $KUBE_APISERVER_ARGS =~ --kubelet-https=([^[:space:],]+) ]]; then
  kube_http="${BASH_REMATCH[1]}"
fi

# Fix: Syntax error in [ "$kube_http" == "true"];then
if [[ "$kube_http" == "" || "$kube_http" == "true" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid5`
else
  echo -en "${re}[WARN]${xx}" `show apid5`
fi
}

api5
echo -en '\n'

api6(){
local ins_bind=""
if [[ $KUBE_APISERVER_ARGS =~ --insecure-bind-address=([^[:space:],]+) ]]; then
  ins_bind="${BASH_REMATCH[1]}"
fi

if [[ "$ins_bind" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid6`
else
  echo -en "${re}[WARN]${xx}" `show apid6`
fi
}

api6
echo -en '\n'

api7(){
local ins_port=""
if [[ $KUBE_APISERVER_ARGS =~ --insecure-port=([^[:space:],]+) ]]; then
  ins_port="${BASH_REMATCH[1]}"
fi

if [[ "$ins_port" == "0" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid7`
else
  echo -en "${re}[WARN]${xx}" `show apid7`
fi
}

api7
echo -en '\n'

api8(){
local sec_port=""
if [[ $KUBE_APISERVER_ARGS =~ --secure-port=([^[:space:],]+) ]]; then
  sec_port="${BASH_REMATCH[1]}"
fi

if [[ "$sec_port" == "0" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid8`
else
  echo -en "${gr}[PASS]${xx}" `show apid8`
fi
}

api8
echo -en '\n'

api9(){
local prof=""
if [[ $KUBE_APISERVER_ARGS =~ --profiling=([^[:space:],]+) ]]; then
  prof="${BASH_REMATCH[1]}"
fi

if [[ "$prof" == "false" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid9`
else
  echo -en "${re}[WARN]${xx}" `show apid9`
fi
}

api9
echo -en '\n'

api10(){
local rep_malf=""
if [[ $KUBE_APISERVER_ARGS =~ --repair-malformed-updates=([^[:space:],]+) ]]; then
  rep_malf="${BASH_REMATCH[1]}"
fi

if [[ "$rep_malf" == "false" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid10`
else
  echo -en "${re}[WARN]${xx}" `show apid10`
fi
}

api10
echo -en '\n'

api11(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" == "" || ! "$adm_cont" =~ AlwaysAdmit ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid11`
else
  echo -en "${re}[WARN]${xx}" `show apid11`
fi
}

api11
echo -en '\n'

api12(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" == "" || "$adm_cont" =~ AlwaysPullImages ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid12`
else
  echo -en "${re}[WARN]${xx}" `show apid12`
fi
}

api12
echo -en '\n'

api13(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" == "" || "$adm_cont" =~ DenyEscalatingExec ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid13`
else
  echo -en "${re}[WARN]${xx}" `show apid13`
fi
}

api13
echo -en '\n'

api14(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" == "" || "$adm_cont" =~ SecurityContextDeny ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid14`
else
  echo -en "${re}[WARN]${xx}" `show apid14`
fi
}

api14
echo -en '\n'

api15(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" == "" || "$adm_cont" =~ NamespaceLifecycle ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid15`
else
  echo -en "${re}[WARN]${xx}" `show apid15`
fi
}

api15
echo -en '\n'

api16(){
local aud_logpa=""
if [[ $KUBE_APISERVER_ARGS =~ --audit-log-path=([^[:space:],]+) ]]; then
  aud_logpa="${BASH_REMATCH[1]}"
fi

if [[ "$aud_logpa" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid16`
else
  echo -en "${gr}[PASS]${xx}" `show apid16`
fi
}

api16
echo -en '\n'

api17(){
local aud_logmax=""
if [[ $KUBE_APISERVER_ARGS =~ --audit-log-maxage=([^[:space:],]+) ]]; then
  aud_logmax="${BASH_REMATCH[1]}"
fi

if [[ "$aud_logmax" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid17`
elif [[ "$aud_logmax" -ge 30 ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid17`
else
  echo -en "${re}[WARN]${xx}" `show apid17`
fi
}

api17
echo -en '\n'

api18(){
local aud_logbac=""
if [[ $KUBE_APISERVER_ARGS =~ --audit-log-maxbackup=([^[:space:],]+) ]]; then
  aud_logbac="${BASH_REMATCH[1]}"
fi

if [[ "$aud_logbac" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid18`
elif [[ "$aud_logbac" -ge 10 ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid18`
else
  echo -en "${re}[WARN]${xx}" `show apid18`
fi
}

api18
echo -en '\n'

api19(){
local aud_logmsize=""
if [[ $KUBE_APISERVER_ARGS =~ --audit-log-maxsize=([^[:space:],]+) ]]; then
  aud_logmsize="${BASH_REMATCH[1]}"
fi

if [[ "$aud_logmsize" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid19`
elif [[ "$aud_logmsize" -ge 100 ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid19`
else
  echo -en "${re}[WARN]${xx}" `show apid19`
fi
}

api19
echo -en '\n'

api20(){
local auth_mode=""
if [[ $KUBE_APISERVER_ARGS =~ --authorization-mode=([^[:space:],]+) ]]; then
  auth_mode="${BASH_REMATCH[1]}"
fi

if [[ "$auth_mode" =~ AlwaysAllow ]]; then
  echo -en "${re}[WARN]${xx}" `show apid20`
else
  echo -en "${gr}[PASS]${xx}" `show apid20`
fi
}

api20
echo -en '\n'

api21(){
local token_auth=""
if [[ $KUBE_APISERVER_ARGS =~ --token-auth-file=([^[:space:],]+) ]]; then
  token_auth="${BASH_REMATCH[1]}"
fi

if [[ "$token_auth" == "" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid21`
else
  echo -en "${re}[WARN]${xx}" `show apid21`
fi
}

api21
echo -en '\n'

api21b(){
local cert_auth=""
if [[ $KUBE_APISERVER_ARGS =~ --kubelet-certificate-authority=([^[:space:],]+) ]]; then
  cert_auth="${BASH_REMATCH[1]}"
fi

if [[ "$cert_auth" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid21b`
else
  echo -en "${gr}[PASS]${xx}" `show apid21b`
fi
}

api21b
echo -en '\n'

api22(){
local cert_key=""
if [[ $KUBE_APISERVER_ARGS =~ --kubelet-client-certificate=([^[:space:],]+) ]]; then
  cert_key="${BASH_REMATCH[1]}"
fi

if [[ "$cert_key" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid22`
else
  echo -en "${gr}[PASS]${xx}" `show apid22`
fi
}

api22
echo -en '\n'

api23(){
local sa_lookup=""
if [[ $KUBE_APISERVER_ARGS =~ --service-account-lookup=([^[:space:],]+) ]]; then
  sa_lookup="${BASH_REMATCH[1]}"
fi

if [[ "$sa_lookup" == "true" ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid23`
else
  echo -en "${re}[WARN]${xx}" `show apid23`
fi
}

api23
echo -en '\n'

api24(){
local adm_cont=""
if [[ $KUBE_APISERVER_ARGS =~ --admission-control=([^[:space:]]+) ]]; then
  adm_cont="${BASH_REMATCH[1]}"
fi

if [[ "$adm_cont" =~ PodSecurityPolicy ]]; then
  echo -en "${gr}[PASS]${xx}" `show apid24`
else
  echo -en "${re}[WARN]${xx}" `show apid24`
fi
}

api24
echo -en '\n'

api25(){
local serv_key=""
if [[ $KUBE_APISERVER_ARGS =~ --service-account-key-file=([^[:space:],]+) ]]; then
  serv_key="${BASH_REMATCH[1]}"
fi

if [[ "$serv_key" == "" ]]; then
  echo -en "${re}[WARN]${xx}" `show apid25`
else
  echo -en "${gr}[PASS]${xx}" `show apid25`
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


#checkfunc
#api1
#api2
