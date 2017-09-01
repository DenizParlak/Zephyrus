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
echo ""
echo ""
echo -en "${bl}Master Node Security Configurations Checking..${xx}"
echo ""
echo -en "${bl}               API Server${xx}"
echo ""
echo ""
echo -en "____________________________________________________________"
echo ""
echo ""
echo ""
echo ""
echo ""

api1(){

allow_priv=$(ps -ef | grep kube-apiserver | grep -o 'allow-privileged=[^ ,]\+' | awk -F "=" '{print $2}')
if [ "$allow_priv" == "false" ];then
echo -en "${gr}OK${xx}"
elif [ "$allow_priv" == "" ]
then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid1
echo ""
api1
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api2(){
anon_auth=$(ps -ef | grep kube-apiserver | grep -o 'anonymous-auth=[^ ,]\+' | awk -F "=" '{print $2}')

if [ "$anon_auth" == "false" ];then
echo -en "${gr}OK${xx}"
elif [ "$anon_auth" == "" ]
then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid2
echo ""
api2
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api3(){
basic_aufi=$(ps -ef | grep kube-apiserver | grep -o 'basic-auth-file=[^ ,]\+' | awk -F "=" '{print $2}')

if [ "$anon_auth" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid3
echo ""
api3
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api4(){
ins_token=$(ps -ef | grep kube-apiserver | grep -o 'insecure-allow-any-token=[^ ,]\+' | awk -F "=" '{print $2}')

if [ "$ins_token" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid4
echo ""
api4
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api5(){
kube_http=$(ps -ef | grep kube-apiserver | grep -o 'kubelet-https=[^ ,]\+' | awk -F "=" '{print $2}')

if [ "$kube_http" == "" ];then
echo -en "${gr}OK${xx}"
elif [ "$kube_http" == "true"];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid5
echo ""
api5
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api6(){
ins_bind=$(ps -ef | grep kube-apiserver | grep -o 'insecure-bind-address=[^ ,]\+' | awk -F "=" '{print $2}')

if [ "$ins_bind" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid6
echo ""
api6
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api7(){
ins_port=$(ps -ef | grep kube-apiserver | grep -o 'insecure-port=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$ins_port" == "0" ]];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid7
echo ""
api7
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api8(){
sec_port=$(ps -ef | grep kube-apiserver | grep -o 'secure-port=[^ ,]\+' | awk -F "=" '{print $2}')


if [[ "$sec_port" == "0" ]];then
echo -en "${re}WARN${xx}"
elif [ "$sec_port" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${gr}OK${xx}"
fi
}

show apid8
echo ""
api8
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api9(){
prof=$(ps -ef | grep kube-apiserver | grep -o 'profiling=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$prof" == "false" ]];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid9
echo ""
api9
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api10(){
rep_malf=$(ps -ef | grep kube-apiserver | grep -o 'repair-malformed-updates=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$rep_malf" == "false" ]];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid10
echo ""
api10
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'
api11(){
alw_admit=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$alw_admit" == "" ]];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid11
echo ""
api11
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api12(){
alw_pull=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$alw_pull" == "AlwaysPullImages" ]];then
echo -en "${gr}OK${xx}"
elif [ "$alw_pull" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid12
echo ""
api12
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api13(){
deny_esc=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$deny_esc" == "DenyEscalatingExec" ]];then
echo -en "${gr}OK${xx}"
elif [ "$deny_esc" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid13
echo ""
api13
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api14(){
sec_cont=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$sec_cont" == "SecurityContextDeny" ]];then
echo -en "${gr}OK${xx}"
elif [ "$sec_cont" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid14
echo ""
api14
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api15(){
namep_life=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$namep_life" == "NamespaceLifecycle" ]];then
echo -en "${gr}OK${xx}"
elif [ "$namep_life" == "" ];then
echo -en "${gr}OK${xx}"
else
echo -en "${re}WARN${xx}"
fi

}

show apid15
echo ""
api15
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api16(){
aud_logpa=$(ps -ef | grep kube-apiserver | grep -o 'audit-log-path=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$aud_logpa" == "" ]];then
echo -en "${re}WARN${xx}"
else
echo -en "${gr}OK${xx}"
fi

}

show apid16
echo ""
api16
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api17(){
aud_logmax=$(ps -ef | grep kube-apiserver | grep -o 'audit-log-maxage=[^ ,]\+' | awk -F "=" '{print $2}')


if [[ "$aud_logmax" == "" ]];then
echo -en "${re}WARN${xx}"
elif [ $aud_logmax >= 30 ];then
echo -en "${gr}OK${xx}"
else
echo -en "${gr}OK${xx}"
fi

}

show apid17
echo ""
api17
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api18(){
aud_logbac=$(ps -ef | grep kube-apiserver | grep -o 'audit-log-maxbackup=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$aud_logbac" == "" ]];then
echo -en "${re}WARN${xx}"
elif [ $aud_logbac >= 10 ];then
echo -en "${gr}OK${xx}"
else
echo -en "${gr}OK${xx}"
fi

}

show apid18
echo ""
api18
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api19(){
aud_logmsize=$(ps -ef | grep kube-apiserver | grep -o 'audit-log-maxsize=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$aud_logmsize" == "" ]];then
echo -en "${re}WARN${xx}"
elif [ $aud_logmsize >= 100 ];then
echo -en "${gr}OK${xx}"
else
echo -en "${gr}OK${xx}"
fi

}

show apid19
echo ""
api19
echo ""
echo -en "____________________________________________________________"
echo ""
echo -en '\n'

api20(){
auth_mode=$(ps -ef | grep kube-apiserver | grep -o 'authorization-mode=[^ ,]\+' | awk -F "=" '{print $2}')

if [[ "$auth_mode" == "AlwaysAllow" ]];then
echo -en "${re}WARN${xx}"
else
echo -en "${gr}OK${xx}"
fi

}

show apid20
echo ""
api20
echo ""
echo -en "____________________________________________________________"
echo ""
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
