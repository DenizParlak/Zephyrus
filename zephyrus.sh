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

# Cache the kube-apiserver command line arguments once to avoid process fork overhead.
# Using "[k]ube-apiserver" to avoid matching the grep process itself.
KUBE_APISERVER_ARGS=$(ps -ef | grep "[k]ube-apiserver" | head -n 1)

# Helper function to extract a flag's value using pure Bash regular expressions without forks.
# It assigns the value directly to the variable named in $1.
get_flag_val() {
  local var_name="$1"
  local flag_name="$2"
  local val=""
  # First check for --flag=value assignment pattern.
  # Use [^[:space:]]+ to capture comma-separated values completely.
  local regex="--${flag_name}=([^[:space:]]+)"
  if [[ "$KUBE_APISERVER_ARGS" =~ $regex ]]; then
    val="${BASH_REMATCH[1]}"
  else
    # Check for standalone flag (e.g. --flag)
    local regex_bool="(^|[[:space:]])--${flag_name}([[:space:]]|$)"
    if [[ "$KUBE_APISERVER_ARGS" =~ $regex_bool ]]; then
      val="true"
    fi
  fi
  printf -v "$var_name" "%s" "$val"
}

api1(){
get_flag_val allow_priv allow-privileged
if [ "$allow_priv" == "false" ];then
echo -en "${gr}[PASS]${xx}"
elif [ "$allow_priv" == "" ]
then
echo "${gr}[PASS]${xx}" $(show apid1)
else
echo -en "${re}[WARN]${xx}" $(show apid1)
fi

}

echo ""
api1
echo -en '\n'

api2(){
get_flag_val anon_auth anonymous-auth

if [ "$anon_auth" == "false" ];then
echo -en "${gr}[PASS]${xx}"
elif [ "$anon_auth" == "" ]
then
echo -en "${gr}[PASS]${xx}" $(show apid2)
else
echo -en "${re}[WARN]${xx}" $(show apid2)
fi

}

api2

api3(){
get_flag_val basic_aufi basic-auth-file

if [ "$basic_aufi" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid3)
else
echo -en "${re}[WARN]${xx}" $(show apid3)
fi

}

echo ""
api3
echo -en '\n'

api4(){
get_flag_val ins_token insecure-allow-any-token

if [ "$ins_token" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid4)
else
echo -en "${re}[WARN]${xx}" $(show apid4)
fi

}

api4
echo -en '\n'

api5(){
get_flag_val kube_http kubelet-https

if [ "$kube_http" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid5)
elif [ "$kube_http" == "true" ];then
echo -en "${gr}[PASS]${xx}" $(show apid5)
else
echo -en "${re}[WARN]${xx}" $(show apid5)
fi

}

api5
echo -en '\n'

api6(){
get_flag_val ins_bind insecure-bind-address

if [ "$ins_bind" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid6)
else
echo -en "${re}[WARN]${xx}" $(show apid6)
fi

}

api6
echo -en '\n'

api7(){
get_flag_val ins_port insecure-port

if [[ "$ins_port" == "0" ]];then
echo -en "${gr}[PASS]${xx}" $(show apid7)
else
echo -en "${re}[WARN]${xx}" $(show apid7)
fi

}

api7
echo -en '\n'

api8(){
get_flag_val sec_port secure-port


if [[ "$sec_port" == "0" ]];then
echo -en "${re}[WARN]${xx}" $(show apid8)
elif [ "$sec_port" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid8)
else
echo -en "${gr}[PASS]${xx}" $(show apid8)
fi
}

api8
echo -en '\n'

api9(){
get_flag_val prof profiling

if [[ "$prof" == "false" ]];then
echo -en "${gr}[PASS]${xx}" $(show apid9)
else
echo -en "${re}[WARN]${xx}" $(show apid9)
fi

}

api9
echo -en '\n'

api10(){
get_flag_val rep_malf repair-malformed-updates

if [[ "$rep_malf" == "false" ]];then
echo -en "${gr}[PASS]${xx}" $(show apid10)
else
echo -en "${re}[WARN]${xx}" $(show apid10)
fi

}

api10
echo -en '\n'

api11(){
get_flag_val adm_control admission-control

if [[ "$adm_control" == *AlwaysAdmit* ]];then
echo -en "${re}[WARN]${xx}" $(show apid11)
else
echo -en "${gr}[PASS]${xx}" $(show apid11)
fi

}

api11
echo -en '\n'

api12(){
get_flag_val adm_control admission-control

if [[ "$adm_control" == *AlwaysPullImages* ]];then
echo -en "${gr}[PASS]${xx}" $(show apid12)
elif [ "$adm_control" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid12)
else
echo -en "${re}[WARN]${xx}" $(show apid12)
fi

}

api12
echo -en '\n'

api13(){
get_flag_val adm_control admission-control

if [[ "$adm_control" == *DenyEscalatingExec* ]];then
echo -en "${gr}[PASS]${xx}" $(show apid13)
elif [ "$adm_control" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid13)
else
echo -en "${re}[WARN]${xx}" $(show apid13)
fi

}

api13
echo -en '\n'

api14(){
get_flag_val adm_control admission-control

if [[ "$adm_control" == *SecurityContextDeny* ]];then
echo -en "${gr}[PASS]${xx}" $(show apid14)
elif [ "$adm_control" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid14)
else
echo -en "${re}[WARN]${xx}" $(show apid14)
fi

}

api14
echo -en '\n'

api15(){
get_flag_val adm_control admission-control

if [[ "$adm_control" == *NamespaceLifecycle* ]];then
echo -en "${gr}[PASS]${xx}" $(show apid15)
elif [ "$adm_control" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid15)
else
echo -en "${re}[WARN]${xx}" $(show apid15)
fi

}

api15
echo -en '\n'

api16(){
get_flag_val aud_logpa audit-log-path

if [[ "$aud_logpa" == "" ]];then
echo -en "${re}[WARN]${xx}" $(show apid16)
else
echo -en "${gr}[PASS]${xx}" $(show apid16)
fi

}

api16

echo -en '\n'

api17(){
get_flag_val aud_logmax audit-log-maxage


if [[ "$aud_logmax" == "" ]];then
echo -en "${re}[WARN]${xx}" $(show apid17)
elif [[ "$aud_logmax" -ge 30 ]];then
echo -en "${gr}[PASS]${xx}" $(show apid17)
else
echo -en "${gr}[PASS]${xx}" $(show apid17)
fi

}

api17
echo -en '\n'

api18(){
get_flag_val aud_logbac audit-log-maxbackup

if [[ "$aud_logbac" == "" ]];then
echo -en "${re}[WARN]${xx}" $(show apid18)
elif [[ "$aud_logbac" -ge 10 ]];then
echo -en "${gr}[PASS]${xx}" $(show apid18)
else
echo -en "${gr}[PASS]${xx}" $(show apid18)
fi

}

api18
echo -en '\n'

api19(){
get_flag_val aud_logmsize audit-log-maxsize

if [[ "$aud_logmsize" == "" ]];then
echo -en "${re}[WARN]${xx}" $(show apid19)
elif [[ "$aud_logmsize" -ge 100 ]];then
echo -en "${gr}[PASS]${xx}" $(show apid19)
else
echo -en "${gr}[PASS]${xx}" $(show apid19)
fi

}

api19
echo -en '\n'

api20(){
get_flag_val auth_mode authorization-mode

if [[ "$auth_mode" == *AlwaysAllow* ]];then
echo -en "${re}[WARN]${xx}" $(show apid20)
else
echo -en "${gr}[PASS]${xx}" $(show apid20)
fi

}

api20
echo -en '\n'

api21(){
get_flag_val token_auth token-auth-file

if [ "$token_auth" == "" ];then
echo -en "${gr}[PASS]${xx}" $(show apid21)
else
echo -en "${re}[WARN]${xx}" $(show apid21)
fi

}

api21
echo -en '\n'


api21b(){
get_flag_val cert_auth kubelet-certificate-authority
if [ "$cert_auth" == "" ];then
echo -en "${re}[WARN]${xx}" $(show apid21b)
else
echo -en "${gr}[PASS]${xx}" $(show apid21b)
fi

}

api21b
echo -en '\n'



api22(){
get_flag_val cert_key kubelet-client-certificate
if [ "$cert_key" == "" ];then
echo -en "${re}[WARN]${xx}" $(show apid22)
else
echo -en "${gr}[PASS]${xx}" $(show apid22)
fi

}

api22
echo -en '\n'



api23(){
get_flag_val cert_key service-account-lookup
if [ "$cert_key" == "" ];then
echo -en "${re}[WARN]${xx}" $(show apid23)
elif [ "$cert_key" == "false" ];then
echo -en "${re}[WARN]${xx}" $(show apid23)
else 
echo -en "${gr}[PASS]${xx}" $(show apid23)
fi

}

api23
echo -en '\n'



api24(){
get_flag_val adm_control admission-control
if [ "$adm_control" == "" ];then
echo -en "${re}[WARN]${xx}" $(show apid24)
elif [[ "$adm_control" != *PodSecurityPolicy* ]];then
echo -en "${re}[WARN]${xx}" $(show apid24)
else
echo -en "${gr}[PASS]${xx}" $(show apid24)
fi

}

api24
echo -en '\n'


api25(){
get_flag_val serv_key service-account-key-file
if [ "$serv_key" == "" ];then
echo -en "${re}[WARN]${xx}" $(show apid25)
else
echo -en "${gr}[PASS]${xx}" $(show apid25)
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
