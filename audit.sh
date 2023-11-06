#/usr/bin/env bash

# ###########################################
# Copyright 2021-3030 LOGHOUSE ADMIN
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ###########################################

# create a tmp-audit folder if it doesn't exist
mkdir -p /tmp-audit

# Create the log file and add a record that this audit began
touch /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
echo "

Copyright 2021-3030 LOGHOUSE ADMIN
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

███████╗██╗   ██╗███████╗ █████╗ ██████╗
██╔════╝╚██╗ ██╔╝██╔════╝██╔══██╗██╔══██╗
███████╗ ╚████╔╝ ███████╗███████║██║  ██║
╚════██║  ╚██╔╝  ╚════██║██╔══██║██║  ██║
███████║   ██║   ███████║██║  ██║██████╔╝
╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════╝

██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝
██║     ██║██║╚██╗██║██║   ██║ ██╔██╗
███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝

 █████╗ ██╗   ██╗██████╗ ██╗████████╗
██╔══██╗██║   ██║██╔══██╗██║╚══██╔══╝
███████║██║   ██║██║  ██║██║   ██║
██╔══██║██║   ██║██║  ██║██║   ██║
██║  ██║╚██████╔╝██████╔╝██║   ██║
╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝   ╚═╝
... by LOGHOUSE ADMIN
... v.1.2.1[MIT]

"  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo -e "${date}: Audit has begun" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Init SSH
# ssh-add ~/.ssh/id_CBUITS_ed25519
# ssh-add ~/.ssh/id_CBUITS_RSA_Fallback

# Init script
# bash /tmp-audit/audit/app/setup.sh

# announce to the user what is running
echo "System Administrator's Tool for Analyzing Network Appliances" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# System Information
# bash /tmp-audit/audit/modules/sysinfo/sysinfo.sh

command_exists()
{
    command -v "$@" > /dev/null 2>&1
}

# cat release info
echo "[REPORT RELEASE INFO]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/*-release >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# uname
echo "[REPORT UNAME]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
uname -a >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# top summary
echo "[REPORT RESOURCES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
top -b -n 1 | head -n 4 >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

if [ "$(uname)" = "Linux" ]
then
    printf 'Processor:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'CPU cores:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'Frequency:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    awk -F: ' /cpu MHz/ {freq=$2} END {print freq " MHz"}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'RAM:          ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    free -h | awk 'NR==2 {print $2}' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    if [ "$(swapon -s | wc -l)" -lt 2 ]
    then
        printf 'Swap:         -\n' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    else
        printf 'Swap:         ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        free -h | awk '/Swap/ {printf $2}' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        printf '\n' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    fi
else
    # we'll assume FreeBSD, might work on other BSDs too
    printf 'Processor:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    sysctl -n hw.model >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'CPU cores:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    sysctl -n hw.ncpu >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'Frequency:    ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    grep -Eo -- '[0-9.]+-MHz' /var/run/dmesg.boot | tr -- '-' ' ' | sort -u >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    printf 'RAM:          ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    sysctl -n hw.physmem | B_to_MiB >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

    if [ "$(swapinfo | wc -l)" -lt 2 ]
    then
        printf 'Swap:         -\n' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    else
        printf 'Swap:         ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        swapinfo -k | awk 'NR>1 && $1!="Total" {total+=$2} END {print total*1024}' | B_to_MiB >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    fi
fi
printf 'Kernel:       ' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
uname -s -r -m >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

printf '\n' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

printf 'Disks:\n' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
if command_exists lsblk && [ -n "$(lsblk)" ]
then
    lsblk --nodeps --noheadings --output NAME,SIZE,ROTA --exclude 1,2,11 | sort | awk '{if ($3 == 0) {$3="SSD"} else {$3="HDD"}; printf("%-3s%8s%5s\n", $1, $2, $3)}'  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
elif [ -r "/var/run/dmesg.boot" ]
then
    awk '/(ad|ada|da|vtblk)[0-9]+: [0-9]+.B/ { print $1, $2/1024, "GiB" }' /var/run/dmesg.boot | sort -u >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
elif command_exists df
then
    df -h --output=source,fstype,size,itotal | awk 'NR == 1 || /^\/dev/' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
else
    printf '[ no data available ]' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
fi

# User and Groups
# bash /tmp-audit/audit/modules/users/users.sh

echo "[USERS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
users >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[GROUPS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
groups >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# groupmembers report
echo "[GROUP MEMBERS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# For every user in /etc/passwd, get their groups
# for user in $(awk -F: '{print $1}' /etc/passwd); do groups $user >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt ; done
cat /etc/group | awk -F: '{print $1, $3, $4}' | while read group gid members; do
    members=$members,$(awk -F: "\$4 == $gid {print \",\" \$1}" /etc/passwd);
    echo "$group: $members" | sed 's/,,*/ /g'  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt ; done
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# users logged in
echo "[REPORT LOGGED IN USERS]"  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
who  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# users at home
echo "[REPORT USERS AT HOME]"  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
ls /home   >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# users without passwords
echo "[USERS WITHOUT PASSWORDS] " >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/shadow | awk -F: '($2==""){print $1}' >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# sudoers report
echo "[REPORT SUDOERS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/sudoers  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[REPORT SUDOERS.D]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
find /etc/sudoers.d/ -type f -exec cat {} \;  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Network Information
# bash /tmp-audit/audit/modules/netinfo/netinfo.sh

# iptables summary
echo "[REPORT IPTABLES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
# list all iptables rules in selected chain, if no chain selected, all chains are selected.
iptables --list >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[REPORT IPTABLES VERBOSE]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
iptables --list -v >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# ports summary
echo  "[REPORT TCP SOCKET NUMBERS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
# enumerate TCP socket connections and processes
# with numbers
ss -tlpn  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo  "[REPORT TCP SOCKET SERVICES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
# with service names
ss -tlp  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo  "[REPORT UDP SOCKET NUMBERS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
# enumerate UDP socket connections and processes
# with numbers
ss -ulpn  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo  "[REPORT UDP SOCKET SERVICES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
# with service names
ss -ulp  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# bash /tmp-audit/audit/modules/netinfo/selinux.sh

echo "[SELINUX ENFORCE?]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
getenforce >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[SELINUX GETSEBOOL]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
getsebool -a | grep -w "on" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[SELINUX GETSEBOOL VERBOSE]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
getsebool -a >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# SSH
# bash /tmp-audit/audit/modules/ssh/ssh.sh

# ssh keys report
echo "[REPORT SSH KEY FILES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
ls /root/.ssh/ >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# ssh keys report
echo "[REPORT AUTHORIZED KEYS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# removing this line, this can be done better.
# cat /root/.ssh/authorized_keys >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Adding this for a more comprehensive look at
# authorized logins when we are on a multi user
# system.

# Any valid user may create a $HOME/.ssh/authorized_keys
# file and add any number of public keys to it. Someone
#  with the corresponding private key will then be able
# to log in as that particular user.

# The process sshd follows is like the following:
# When a new connection comes in sshd asks the client
# for the username.

# If the username exists in /etc/passwd, sshd then reads
# the name of the user's home directory from the sixth
# field in /etc/passwd.

# It then checks if .ssh/authorized_keys exists in that
# user's home directory and if permissions are correctly
# set on both the .ssh directory and authorized_keys file.

# If those conditions are met, sshd will then attempt to
# authenticate the client's private key against the public
# key stored in $HOME/.ssh/authorized_keys.

# If the client possesses the matching private key,
# sshd will allow it access.

for X in $(cut -f6 -d ':' /etc/passwd |sort |uniq); do
    if [ -s "${X}/.ssh/authorized_keys" ]; then
        echo "### ${X}: "  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        cat "${X}/.ssh/authorized_keys" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        echo ""  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    fi
done
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[/etc/ssh/sshd_config]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/ssh/sshd_config  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[/root/.ssh/config]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /root/.ssh/config  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

## 0.0.13 - maybe this could be done better..  the pattern matching
## below is bound to be trouble later on when I accidentally suck
## up an example config and think we're offering root via ssh

echo "[SSH PermitRootLogin: /etc/ssh/*config]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/ssh/*config | grep PermitRootLogin >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[SSH PermitRootLogin: /root/.ssh/config]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /root/.ssh/config | grep PermitRootLogin >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Mounts
# bash /tmp-audit/audit/modules/mounts/drives.sh

# fstab summary
echo "[REPORT FSTAB]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/fstab | tail -n +7  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[REPORT BLOCKS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
blkid >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[REPORT MOUNTS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
mount >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Services
# bash /tmp-audit/audit/modules/services/cron.sh

# cron jobs report
echo "[REPORT CRON JOBS]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
ls /etc/cron* >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# extended cron info

echo "[REPORT CRON JOBS, EXT.]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
  if [ -x "$(command -v chronyc)" ]; then
    echo "This system uses Chrony" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    echo "Enumerating user jobs..."  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    for user in $(cut -f1 -d; /etc/passwd); do
      echo "User cronjob report: $user" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      crontab -u $user -l >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    done
  else
    if [ -x "$(command -v ntpd)" ]; then
      echo "This system is using ntpd" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      echo "Enumerating user jobs..."  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      for user in $(cut -f1 -d; /etc/passwd); do
        echo "User cronjob report: $user" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        crontab -u $user -l >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      done
  else
    if [ -x "$(command -v systemd-timesyncd)" ]; then
      echo "This system is using systemd-timesyncd" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      echo "Enumerating user jobs..." >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      for user in $(cut -f1 -d; /etc/passwd); do
        echo "User cronjob report: $user" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
        crontab -u $user -l >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
      done
   else
      echo "Chron service was neither chrony, ntpd or systemd-timesyncd"  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
    fi
  fi
fi

# bash /tmp-audit/audit/modules/services/nginx.sh

# nginx summary
echo  "[REPORT NGINX]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
nginx -T  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# bash /tmp-audit/audit/modules/services/php.sh

echo "[PHP VERSION]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
php -v  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[PHP MODULES]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
php -m  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[PHP USER AND GROUP ID]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
ps aux | grep php-cgi  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

echo "[PHP CONFIG]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/php.ini  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/php/7.0/fpm/php.ini  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
ls  /etc/php.d/  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat  /etc/php.d/  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Configs
# bash /tmp-audit/audit/modules/configs/sssd.sh

echo "[REPORT SSSD]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /etc/sssd/sssd.conf >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Logs
# bash /tmp-audit/audit/modules/logs/logs.sh

# secure log
echo "[REPORT SECURE LOG]" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
cat /var/log/secure  >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt
printf "\n\n" >> /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt

# Send reports home
# bash /tmp-audit/audit/app/send.sh

# rsync -avzh /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt  jkegel@nixmgmt:/home/jkegel/logs

# scp -i ~/.ssh/id_loghouse_logcatcher /tmp-audit/*.txt logcatcher@nixmgmt:/home/logcatcher/logs
scp /tmp-audit/auditlog-`hostname`-$(date +%Y%m%d).txt  logcatcher@192.168.10.30:/home/logcatcher/logs

exit

# curl URL HERE > audit-time.sh && chmod +x audit-time.sh && ./audit-time.sh && exit
