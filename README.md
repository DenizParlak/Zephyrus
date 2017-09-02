# Zephyrus
Auditing &amp; Hardening Tool for Kubernetes

Zephyrus is developing for system and application administrators, security specialists, auditors, help desk, and platform deployment personnel who plan to develop, deploy, assess, or secure solutions that incorporate Kubernetes.

Zephyrus provides completely hardening solution and establishing a secure configuration posture for Kubernetes.


## Master Node Security Configuration

- 1.1.1 Ensure that the --allow-privileged argument is set to false
- 1.1.2 Ensure that the --anonymous-auth argument is set to false
- 1.1.3 Ensure that the --basic-auth-file argument is not set
- 1.1.4 Ensure that the --insecure-allow-any-token argument is not set
- 1.1.5 Ensure that the --kubelet-https argument is set to true
- 1.1.6 Ensure that the --insecure-bind-address argument is not set
- 1.1.7 Ensure that the --insecure-port argument is set to 0
- 1.1.8 Ensure that the --secure-port argument is not set to 0
- 1.1.9 Ensure that the --profiling argument is set to false
- 1.1.10 Ensure that the --repair-malformed-updates argument is set to false
- 1.1.11 Ensure that the admission control policy is not set to AlwaysAdmit
- 1.1.12 Ensure that the admission control policy is set to AlwaysPullImages
- 1.1.13 Ensure that the admission control policy is set to DenyEscalatingExec
- 1.1.14 Ensure that the admission control policy is set to SecurityContextDeny
- 1.1.15 Ensure that the admission control policy is set to NamespaceLifecycle
- 1.1.16 Ensure that the --audit-log-path argument is set as appropriate
- 1.1.17 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate
- 1.1.18 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate
- 1.1.19 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate
- 1.1.20 Ensure that the --authorization-mode argument is not set to AlwaysAllow

### ChangeLog

2/9/2017 - Added 20 audit modules for master node.

# Requirements

Zepyhrus has been written in bash script that it works in just Linux yet.

Make sure that the Kubernetes package is installed on the system and kube-apiserver service is running.

# Usage

git clone https://github.com/DenizParlak/Zephyrus.git && cd Zephyrus && chmod +x Zephyrus.sh && ./Zephyrus.sh



![Zephyrus](https://i.hizliresim.com/VMkk6Z.jpg)
