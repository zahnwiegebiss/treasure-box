#!/bin/bash
### Bascic configurations
saslpasswd2 -a libvirt tusz

postconf -e mailbox_size_limit=512000000
systemctl reload postfix

### IPA
ipa-client-install --mkhomedir

### Install packages
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
vim /etc/yum.repos.d/epel.repo # disable epel

yum install cockpit-ovirt-dashboard.noarch cockpit-machines-ovirt bash-completion mlocate deltarpm vim-minimal strace sg3_utils
yum install --enablerepo epel vim-enhanced bash-completion iotop iftop ncdu htop bash-completion-extras.noarch 

### Update system
yum clean all; rm -rf /var/cache/yum/*; yum update

### Copy packages to HE
yum --downloadonly reinstall --enablerepo epel htop iftop iotop ncdu
scp /var/cache/yum/x86_64/7/epel/packages/[htop,iftop,ncdu]* root@kvm-ohe201:~/
